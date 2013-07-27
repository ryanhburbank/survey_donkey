get '/questions/:question_id/edit' do
  @question = Question.find(params[:question_id])
  @answers = @question.answers.order("id")
  erb :'/surveys/edit_question'
end

post '/questions/:question_id/answers/new' do
  Answer.create(question_id: params[:question_id])
  redirect back
end

post '/questions/:survey_id/new' do
  @question = Question.new(survey_id: params[:survey_id], text: params[:question][:text])
  p @question
  @question.save
  redirect back
end

post '/questions/:question_id/delete' do
  Question.find(params[:question_id]).destroy
  redirect back
end

post '/questions/:question_id/edit' do
  @question = Question.find(params[:question_id])
  Question.update(@question.id, :text => params[:question][:text])
  redirect back
end



