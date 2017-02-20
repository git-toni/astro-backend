class AuthController < ApplicationController
  def dummy
    render json:{msg: 'Dummy sent'}, status: :ok
  end
end
