class UsersController < ApplicationController
  before_action :authenticate_user! 
  before_action :set_user, only: [:edit, :show, :destroy, :update]
  
  def profile
    @user = current_user
    render :edit
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)  
        format.html { redirect_to @user, notice: "User successfully updated" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @users = User.all.order("name ASC")
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :leader, :role_id)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

