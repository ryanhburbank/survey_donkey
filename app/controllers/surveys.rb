get '/survey/:id/results' do
  @survey = Survey.find(params[:id])
  @questions = @survey.questions

  erb :survey_results
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
