get '/' do 
  erb :index
end

get '/register' do
  erb :index

end

post '/register' do
  p params
  puts request.body.read
  user = User.new(password: params[:password], 
                  password_confirmation: params[:password_confirmation], 
                  email: params[:email])
  if user.save
    session[:id] = user.id
    p session
    redirect to('/profile') #change me to redirect to profile when we have it
  else
    p user.errors
    redirect to('/register')
  end
end

get '/login' do
  erb :index
end

post '/login' do
  user = User.find_by_email(params[:email])
  if user
    session[:id] = user.id
    redirect to('/profile') #change me to redirect to profile when we have it
  else
    redirect to('/login')
  end
end

get '/logout' do 
  session[:id] = nil
  redirect to('/')
end

