class ApplicationController < ActionController::API
  include AuthHelper
  include RendersHelper
  include HooksHelper
  before_action :require_auth

end
