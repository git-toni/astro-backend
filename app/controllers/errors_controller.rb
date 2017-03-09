class ErrorsController < ApplicationController
  skip_before_action :require_auth
  def not_found
    render json: {msg: 'Page not found'}, status: 404
  end
end
