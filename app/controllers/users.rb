get '/profile' do
  if logged_in?
    user = current_user
    @surveys = all_surveys(user)
    @sent_surveys = sent_surveys
    erb :'/users/profile'
  else
    access_failure
    erb :index
  end
end

get '/users/register' do
  erb :index
end

post '/users/register' do
  user = User.new(password: params[:password], 
                  password_confirmation: params[:password_confirmation], 
                  email: params[:email])
  if user.save
    session[:id] = user.id
    p session
    redirect to('/profile') #change me to redirect to profile when we have it
  else
    registration_errors(user)
    redirect to('/register')
  end
end

get '/users/login' do
  erb :index
end

post '/users/login' do
  if login_valid?
    session[:id] = user.id
    redirect to('/profile') #change me to redirect to profile when we have it
  else
    login_failure
    redirect to('/login')
  end
end

get '/users/logout' do 
  session.clear
  redirect to('/')
end
