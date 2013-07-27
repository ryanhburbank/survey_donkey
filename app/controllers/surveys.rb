get '/survey/:id/results' do
  @survey = Survey.find(params[:id])
  @questions = @survey.questions

  erb :'/surveys/survey_results'
end

get '/survey/:survey_id/edit' do
  @survey = Survey.find(params[:survey_id])
  @questions = @survey.questions.order("id")
  p @questions
  erb :'/surveys/edit_survey'
end


post '/survey/questions/:question_id/edit' do
  @question = Question.find(params[:question_id])
  Question.update(@question.id, :text => params[:question][:text])
  redirect back
end

get '/survey/question/:question_id/edit' do

  erb :'/surveys/edit_survey'
end

post '/survey/:survey_id/edit' do
  @survey_title = params[:survey][:title]
  Survey.update(params[:survey_id], :title => params[:survey][:title])
  redirect back
end

post '/questions/:survey_id/new' do
  @question = Question.new(survey_id: params[:survey_id], text: params[:question][:text])
  p @question
  @question.save
  redirect back
end

get '/survey/:id' do
  @questions = Survey.find_by_id(params[:id]).questions
  erb :"/surveys/take_survey"
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
