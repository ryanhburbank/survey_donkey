get '/profile' do
  @user = User.find(session[:id])
  @surveys = @user.surveys.all
  @sent_surveys = @user.surveys.where(:sent => 1)

  erb :'/users/profile'
end
