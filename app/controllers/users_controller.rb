class UsersController < ApplicationController
  def index
    render json: User.all, status: :ok
  end
  def profile
    begin
      u = User.find user_id
      render json: u, serializer:"#{user_authorization}UserSerializer".constantize, root: false
    rescue
      render json: {msg: 'Error finding user'}, status: :not_found
    end
  end
end
