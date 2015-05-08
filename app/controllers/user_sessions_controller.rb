class UserSessionsController < ApplicationController
	skip_before_filter :require_login, except: [:destroy]
  respond_to :html, :json
  
  def new
  	@user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:notice] = "login successful"
  	  respond_with(@user) do |format|
	  		format.html { redirect_back_or_to(:users) }
	  		format.json { render text: "Logged in", status: :ok }
      end
    else
        flash.now[:alert] = "login failed"
        render :new
    end
  end

  def destroy
  	logout
  	flash[:notice] = "Logged out"
    respond_with do |format|
  		format.html { redirect_to :login}
  		# format.json { render text: "Logged out", status: :ok}
  	end
  end
end
