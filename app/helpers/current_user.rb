def current_user
  @user ||= session[:user_id]
end
