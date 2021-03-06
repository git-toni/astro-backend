class UsersController < ApplicationController
  before_action(except:[:index]) { retrieve_resource('User', user_id) }
  before_action :self_access, only:[:settings]
  skip_before_action :require_auth, only:[:index]
  def index
    #binding.pry
    render json: User.all, each_serializer: 'ExternalUserSerializer'.constantize, status: :ok
  end
  def profile
    render json: @resource, serializer:"#{user_authorization}UserSerializer".constantize, root: false, status: :ok
  end
  def settings
    render json: {display_preferences:{ background_color: 'Blue' }, notification_preferences:{}}
  end
  private
  def self_access
    unless current_user == @resource
      render_feedback("Can't access other's settings")
      return
    end
  end
end
