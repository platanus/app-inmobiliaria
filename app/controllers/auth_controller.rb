class AuthController < ApplicationController
  PROVIDER_HOST = ENV['API_HOST']
  CLIENT_ID = ENV['APP_CLIENT_ID']
  CLIENT_SECRET = ENV['APP_CLIENT_SECRET']
  REDIRECT_URI = Rails.application.routes.url_helpers.process_auth_url
  API_SCOPE = 'public'

  def request_auth
    params = {
        client_id: CLIENT_ID,
        redirect_uri: REDIRECT_URI,
        response_type: 'code',
        scope: API_SCOPE
    }
    oauth_url = "#{PROVIDER_HOST}/oauth/authorize?#{params.to_param}"
    redirect_to oauth_url
  end

  def process_auth
    return unless validate_redirect
    auth_code = params[:code]
    body = exchange_code_for_tokens(auth_code)
    access_token = body["access_token"]
    # refresh_token = body["refresh_token"]

    user = User.create(
        auth_code: auth_code, access_token: access_token#,  refresh_token: refresh_token
    )
    session[:user_id] = user.id
    notice = "Account Authorized Succesfully"
    render json: { notice: notice }
  end

  private

  def validate_redirect
    if params[:error].present? || params[:code].blank?
      error =
        if params[:error].present?
          "#{params[:error]} - #{params[:error_description]}"
        else
          "Authorization Code Not Present"
        end
      render json: { error: "Error in Auth request: #{error}" }
      false
    else
      true
    end
  end

  def exchange_code_for_tokens(auth_code)
    conn = Faraday.new(PROVIDER_HOST)
    params = {
        grant_type: "authorization_code",
        code: auth_code,
        client_id: ENV.fetch('APP_CLIENT_ID'),
        client_secret: ENV.fetch('APP_CLIENT_SECRET'),
        redirect_uri: REDIRECT_URI,
        response_type: "code"
    }
    oauth_url = "/oauth/token"
    response = conn.post oauth_url, params
    JSON.parse(response.body)
  end
end
