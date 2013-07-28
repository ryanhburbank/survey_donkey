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


