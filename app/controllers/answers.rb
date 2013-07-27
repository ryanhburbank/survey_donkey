post '/answers/:answer_id/edit' do
  answer = Answer.find(params[:answer_id])
  if authorized?(answer.question.survey_id)
    Answer.update(params[:answer_id], text: params[:answer][:text])
    redirect back
  else
    post_failure
    erb :index
  end
end

post '/answers/:answer_id/delete' do
  answer = Answer.find(params[:answer_id])
  if authorized?(answer.question.survey_id)
    Answer.find(params[:answer_id]).destroy
    redirect back
  else
    post_failure
    erb :index
  end
end

