get '/questions/:question_id/edit' do
  @question = Question.find(params[:question_id])
  if authorized?(@question.survey_id)
    @answers = @question.answers.order("id")
    erb :'/surveys/edit_question'
  else 
    get_failure
    erb :index
  end
end

post '/questions/:question_id/answers/new' do
  question =  Question.find(params[:question_id])
  if authorized?(question.survey_id)
    answer = Answer.new(question_id: params[:question_id])
    p answer
    answer.save
    answer.errors.each {|error| p error}
    redirect back
  else
    post_failure
    erb :index
  end
end

post '/questions/:survey_id/new' do
  if authorized?(params[:survey_id])
    @question = Question.new(survey_id: params[:survey_id], text: params[:question][:text])
    @question.save
    redirect back
  else
    post_failure
    erb :index
  end
end


post '/questions/:question_id/delete' do
  question = Question.find(params[:question_id])
  if authorized?(question.survey_id)
    question.destroy
    redirect back
  else
    post_failure
    erb :index
  end
end


post '/questions/:question_id/edit' do
  @question = Question.find(params[:question_id])
  if authorized?(@question.survey_id)
    Question.update(@question.id, :text => params[:question][:text])
    redirect back
  else 
    post_failure
    erb :index
  end
end

post '/questions/:question_id/delete' do
  Question.find(params[:question_id]).destroy
  redirect back
end




