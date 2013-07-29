def errors_message(object)
  error_message = ""
  object.errors.each_with_index do |error, index|
    error_message << "Error#{index +1 }: #{error}"
  end
  flash[:error] = error_message
end

def current_user?
  @user ||= session[:id]
end

def current_user
  @user ||= User.find(session[:id])
end

def logged_in?
  true if session[:id]
end


def login_valid?(email, password)

  user = User.find_by_email(email)
  if user
    p user
    true if user.password == password
  else
    false
  end
end

def authorized?(survey_id)
  survey = Survey.find(survey_id)
  session[:id] == survey.user.id
end

def current_survey(survey_id)
  Survey.find(survey_id)
end

def all_surveys(user)
  user.surveys.all
end

def sent_surveys(user)
  user.surveys.where(:sent => 1)
end


def current_question(question_id)
  Question.find(question_id)
end

def get_failure
  flash[:error] = "You are not authorized to access this page!"
end

def post_failure
  flash[:error] = "You are not authorized to change this data!"
end

def login_failure
  flash[:error] = "Login failed! Please try again."
end

def password_update(current_password, new_pass, new_pass_confirm)
  @user = User.find(session[:id])
  if @user.authenticate(current_password) && new_pass == new_pass_confirm
     @user.update_attributes(:password => new_pass,
                             :password_confirmation => new_pass_confirm)
    if @user.authenticate(current_password)
      flash[:error] = "Authentication failed, please try again"
      redirect to('/users/edit')
    else
      flash[:error] = "Password update successful!"
      redirect to('/users/edit')
    end
  else
    flash[:error] = "Authentication failed, please try again"
    redirect to('/users/edit')
  end
end

def email_update(current_password, new_email)
  user = User.find(session[:id])
  @user = user.authenticate(current_password)

  if @user
     @user.update_attributes(:email => new_email,
                             :password => current_password,
                             :password_confirmation => current_password)
     flash[:error] = "Email update successful!"
     redirect to('/users/edit')
  else
    flash[:error] = "Authentication failed, please try again"
    redirect to('/users/edit')
  end
end

def valid_handles(handles)
  handles = handles.split(',')
  handles.map!{|handle| handle.strip }
  handles = handles.select{|handle|handle.match(/@([A-Za-z0-9_]{1,15})/)}
  handles.map!{|handle| " " + handle }
end


def valid_body(body)
  body.strip
end

def handle_size(handles)
  count = 0
  handles.each{|handle| count += handle.length}
  count
end

def tweet_error(handles, body)
  character_count = (150 - (handle_size(handles) + body.length))
  flash[:error] = "Your tweet was #{character_count} characters too long!"
end

def valid_tweet?(handles, body)
  p handle_size(handles)
  p body.length
  # p handle_size(handles)
  # p handle_size(handles).size
  # p body.count
  # p body.count.class
 handle_size(handles) + body.length < 128
end

def tweet_construct(handles, body, survey)
  body + handles.join + " " + "localhost:9393/url/" + survey.url
end

def send_tweet(staged_tweet)
  Twitter.update(staged_tweet)
end




