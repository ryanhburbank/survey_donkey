get '/survey/:id/results' do
  @survey = Survey.find(params[:id])
  @response = 

  erb :survey_results
end
