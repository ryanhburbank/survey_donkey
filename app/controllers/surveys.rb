get '/survey/:id/results' do
  @survey = Survey.find(params[:id])
  @questions = @survey.questions
  
  erb :'/surveys/survey_results'
end


