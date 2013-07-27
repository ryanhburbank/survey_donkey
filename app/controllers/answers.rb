post '/answers/:answer_id/edit' do
  answer = Answer.update(params[:answer_id], text: params[:answer][:text])

  redirect back
end

post '/answers/:answer_id/delete' do
  Answer.find(params[:answer_id]).destroy
  redirect back
end

