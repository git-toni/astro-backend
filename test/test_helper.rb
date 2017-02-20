ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'helpers/general_helper'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  include GeneralHelper
  ActiveRecord::FixtureSet.context_class.send :include, GeneralHelper



  fixtures :all
  $redis.flushdb if Rails.env == 'test'
end
