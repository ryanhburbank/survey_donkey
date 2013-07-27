def errors_message(object)
  error_message = ""
  object.errors.each_with_index do |error, index|
    error_message << "Error#{index +1 }: #{error}"
  end
  flash[:errors] = error_message
end

def current_user
  @user ||= User.find(session[:id])
end

def logged_in?
  true if session[:id]
end


def login_valid?(email)
  user = User.find_by_email(params[:email])
  true if user.password == params[:password]
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
  user.surveys.where(sent:1)
end


def current_question(question_id)
  Question.find(params[:question_id])
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


