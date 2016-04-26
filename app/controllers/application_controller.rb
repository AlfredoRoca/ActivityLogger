class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	skip_before_action :verify_authenticity_token, if: :json_request?
  
	helper_method :offset_utc

  include ActionView::Helpers::DateHelper

  def version
    render 'layouts/revision'
  end
	
private
	# def not_authenticated
	# 	redirect_to login_path, alert: "Please, login first"
	# end

  def offset_utc
    tz = ActiveSupport::TimeZone.new('Madrid')
    tz.utc_offset / 3600
  end

  protected

	  def json_request?
	    request.format.json?
	  end

end


