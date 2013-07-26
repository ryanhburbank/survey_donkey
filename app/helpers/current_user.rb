def current_user
  @user ||= session[:id]
end
