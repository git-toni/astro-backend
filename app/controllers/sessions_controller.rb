class SessionsController < ApplicationController
  skip_before_action :require_auth, only: :create
  def loogout
    head :ok
  end
  def create
    user = User.find_by(email: auth_params[:email])
    if user.authenticate(auth_params[:password])
      #jwt = JsonWebToken.issue({user_id: user.id})
      #jwt = JsonWebToken.issue(Payload.new(user))
      jwt = JwtFactory.create(user)
      render json: {jwt: jwt}
    else
      render json: 'Incorrect Login', status: :unauthorized
    end
  end

  private
    def auth_params
      params.require(:auth).permit(:email, :password)
    end
end
