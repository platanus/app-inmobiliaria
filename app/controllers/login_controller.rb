class LoginController < ApplicationController

  def login
    if params[:id] == 'new'
      user = User.create
    else
      raise "Wrong id format" unless params[:id].to_i.positive?
      exists = User.exists? id: params[:id]
      user = User.find_or_create_by id: params[:id]
    end
    session[:user_id] = user.id
    verb = exists ? 'found' : 'created'
    render json: { notice: "User id ##{user.id} #{verb} and logged in"}
  end

  def logout
    session[:user_id] = nil
    @current_user = nil
    render json: { notice: "Logged out"}
  end

  def show_current_user
    render json: { user: current_user.to_json }
  end
end
