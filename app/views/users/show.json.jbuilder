	json.extract! @user, :name, :email, :admin
	json.url user_url(@user, format: :json)
