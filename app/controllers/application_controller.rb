class ApplicationController < ActionController::API
  include AuthHelper
  include RendersHelper
  before_action :require_auth

end
