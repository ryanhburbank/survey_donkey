get '/survey/:id/results' do
  @survey = Survey.find(params[:id])
  @questions = @survey.questions

  erb :survey_results
end
