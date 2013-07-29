get '/surveys/new' do
  user = User.find(session[:id])
  if user
    survey = Survey.new(title: "New Survey", user_id: user.id)
    survey.save
    survey.unique_url
  else
    errors_message(survey)
    redirect to('/')
  end
    redirect to("/surveys/#{survey.id}/edit")
end


get '/surveys/:survey_id/results' do
  if authorized?(params[:survey_id]) 
    @survey = current_survey(params[:survey_id])
    @questions = @survey.questions
    erb :'/surveys/survey_results'
  else
    get_failure
    erb :index
  end
end

get '/surveys/:survey_id/edit' do
  if authorized?(params[:survey_id])
    @survey = current_survey(params[:survey_id]) 
    erb :"/surveys/edit_survey"
  else
    get_failure
    erb :index
  end
end

get '/surveys/:survey_id/send' do
  if authorized?(params[:survey_id])
    @survey = current_survey(params[:survey_id])
    erb :'send/send_portal'
  else
    get_failure
    redirect to('/')
  end
end


post '/surveys/questions/:question_id/edit' do
  @question = current_question(params[:question_id])
  if authorized?(@question.survey.id)
    Question.update(@question.id, :text => params[:question][:text])
    redirect back
  else 
    post_failure
    erb :index
  end
end

get '/surveys/question/:question_id/edit' do
  question = current_question(params[:question_id])
  if authorized?(@question.survey.id)
    erb :'/surveys/edit_survey'
  else
    get_failure
    erb :index
  end
end

post '/surveys/:survey_id/delete' do
  if authorized?(params[:survey_id])
    survey = Survey.find(params[:survey_id])
    survey.destroy
    redirect back
  else
    post_failure
    erb :index
  end
end

post '/surveys/:survey_id/edit' do
  if authorized?(params[:survey_id])
    @survey_title = params[:survey][:title]
    Survey.update(params[:survey_id], :title => params[:survey][:title])
    
    redirect back
  else
    post_failure
    erb :index
  end
end


get '/surveys/:survey_id' do
  if authorized?(params[:survey_id])
    redirect to("/surveys/#{params[:survey_id]}/edit")
  else 
    get_failure
    erb :index
  end
end

post '/surveys/:id/response' do
  survey = Survey.find_by_id(params[:id])
  p params
  survey.questions.each do |question|
    response = Response.new(:email => params[:email],
                            :answer_id => params[:"#{question.id}"].to_i)
    p response
    response.save
  end

  redirect to('/thanks')
end


get '/url/:url' do
  @survey = Survey.find_by_url(params[:url])
  if @survey
    erb :"/surveys/take_survey"
  else
    flash[:error] = "no survey found!"
    redirect to('/')
  end
  # redirect to("/survey/#{@survey.id}")
end


