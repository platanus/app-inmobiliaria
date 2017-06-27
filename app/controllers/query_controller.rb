class QueryController < ApplicationController

  def products
    render json: { api_response: QueryService.new(current_user).products }
  end
end
