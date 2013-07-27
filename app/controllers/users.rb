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
  user = User.find_by_email(params[:email])
  if user.authenticate(params[:password])
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

get '/users/edit' do
  @user = current_user
  if @user
    erb :'/users/edit_account'
  else
    get_failure
    redirect to('/')
  end
end

post '/users/edit/password' do 
  user = current_user
  password_update(params[:current_password], 
                 params[:new_password], 
                 params[:new_password_confirmation])
end

post '/users/edit/email' do
  @user = current_user
  email_update(params[:current_password],
               params[:new_email])
end
