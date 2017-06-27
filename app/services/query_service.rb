class QueryService

  API_HOST = ENV.fetch('API_HOST')

  def initialize(user)
    @user = user
  end

  def products
    query('productos')
  end

  def query(resource)
    conn = Faraday.new(API_HOST)
    params = {
       access_token: @user.access_token,
    }
    path = "/api/v1/#{resource}"
    response = conn.get path, params
    JSON.parse(response.body)
  rescue JSON::ParserError
    response.body
  end
end