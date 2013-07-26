get '/profile' do
  @user = User.find(session[:id])
  @surveys = @user.surveys.all

  erb :'/users/profile'
end
