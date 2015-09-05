class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	skip_before_action :verify_authenticity_token, if: :json_request?

	before_filter :require_login, except: :version
	helper_method :require_admin, :offset_utc

  def version
    render 'layoutas/revision'
  end
	
private
	def not_authenticated
		redirect_to login_path, alert: "Please, login first"
	end

	def require_admin
		 unless current_user && current_user.admin
		 	respond_to do |format|
				format.html { redirect_to root_path, notice: 'You are not an administrator!' }
				format.json { head :no_content }
			end
		end
	end

  def offset_utc
    tz = ActiveSupport::TimeZone.new('Madrid')
    tz.utc_offset / 3600
  end

  protected

	  def json_request?
	    request.format.json?
	  end

end


