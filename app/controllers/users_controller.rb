class UsersController < ApplicationController
  before_action { retrieve_resource('User', user_id) }
  before_action :self_access, only:[:settings]
  def profile
    render json: @resource, serializer:"#{user_authorization}UserSerializer".constantize, root: false, status: :ok
  end
  def settings
    render json: {display_preferences:{}, notification_preferences:{}}
  end
  private
  def self_access
    unless current_user == @resource
      render_feedback("Can't access other's settings")
      return
    end
  end
end
