get '/surveys/new' do
  user = User.find(session[:id])
  if user
    survey = Survey.new(title: "New Survey", user_id: user.id)
    puts "SURVEY BEFORE SAVE"
    p survey
    survey.save
    puts "SAVED SURVEY"
    p survey
  else
    #flash message that user must be logged in
    redirect to('/')
  end
    redirect to("/survey/#{survey.id}/edit")
end
get '/surveys/:survey_id/results' do
  if authorized?(params[:survey_id]) 
    @survey = current_survey(params[:survey_id])
    @questions = @survey.questions

    erb :'/surveys/survey_results'
  else
    access_failure
    erb :index
  end
end

get '/surveys/:survey_id/edit' do
  if authorized?(params[:survey_id]) 
    @survey = current_survey(params[:survey_id])
    @questions = @survey.questions.order("id")
    erb :'/surveys/edit_survey'
  else
    access_failure
    erb :index
  end
end


post '/surveys/questions/:question_id/edit' do
  @question = current_question(params[:question_id])
  if authorized?(@question.survey.id)
    Question.update(@question.id, :text => params[:question][:text])
    redirect back
  else 
    update_failure
    erb :index
  end
end

get '/surveys/question/:question_id/edit' do
  question = current_question(params[:question_id])
  if authorized?(@question.survey.id)
    erb :'/surveys/edit_survey'
  else
    access_failure
    erb :index
  end
end

post '/surveys/:survey_id/edit' do
  if authorized?(params[:survey_id])
    @survey_title = params[:survey][:title]
    Survey.update(params[:survey_id], :title => params[:survey][:title])
    redirect back
  else
    update_failure
    erb :index
  end
end


get '/surveys/:survey_id' do
  if authorized?(params[:survey_id])
    redirect to("/surveys/#{params[:survey_id]}/edit")
  else 
    access_failure
    erb :index
  end
end

post '/survey/:id/response' do
  @survey = Survey.find_by_id(params[:id])
  @survey.questions.each do |question|
    response = Response.new(:email => params[:email],
                            :answer_id => params[:"#{question.id}"])
    response.save
  end

  redirect to('/thanks')
end

get '/url/:url' do
  @survey = Survey.find_by_url(params[:url])
  erb :"/surveys/take_survey"
  # redirect to("/survey/#{@survey.id}")
end
