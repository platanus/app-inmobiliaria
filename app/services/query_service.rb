class QueryService

  API_HOST = ENV.fetch('API_HOST')

  def initialize(user)
    @user = user
  end

  def products

  end

  def query(resource)
    conn = Faraday.new(API_HOST)
    params = {
       access_token: @user.access_token,
    }
    path = "/api/v1/#{resource}"
    response = conn.post path, params
    JSON.parse(response.body)
  end
end