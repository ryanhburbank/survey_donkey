get '/profile' do
  if logged_in?
    user = current_user
    @surveys = all_surveys(user)
    @sent_surveys = sent_surveys(user)
    erb :'/users/profile'
  else
    get_failure
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
  redirect to('/')
end

post '/users/login' do
  if login_valid?(params[:email], params[:password])
    session[:id] = user.id
    redirect to('/profile') #change me to redirect to profile when we have it
  else
    login_failure
    redirect to('/')
  end
end

get '/users/logout' do 
  session.clear
  redirect to('/')
end
