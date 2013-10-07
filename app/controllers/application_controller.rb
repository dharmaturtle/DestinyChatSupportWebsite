class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_timezone

  protected
  def set_timezone
    tz_off = cookies[:timezone]
    Time.zone = ActiveSupport::TimeZone[tz_off.to_i] unless tz_off.nil?
  end
end
