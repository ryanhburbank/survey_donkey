def current_user
  @user ||= session[:id]
end

def authorized?(survey_id)
  survey = Survey.find(survey_id)
  session[:id] == survey.user.id
end

def current_survey(survey_id)
  Survey.find(survey_id)
end

def access_failure
  flash[:error] = "You are not authorized to access this page!"
end

def current_question(question_id)
  Question.find(params[:question_id])
end

def update_failure
  flash[:error] = "You are not authorized to change this data!"
end
