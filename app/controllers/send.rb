
get "/send/:survey_id/tweet" do
  if authorized?(params[:survey_id]) 
    @survey = current_survey(params[:survey_id])
    erb :"/send/send_tweet"
  else
    get_failure
    erb :index
  end
end

post "/send/:survey_id/tweet" do
  @survey = current_survey(params[:survey_id])
  if authorized?(params[:survey_id])
    handles = valid_handles(params[:handles])
    body = valid_body(params[:body])
    if valid_tweet?(handles,body)
      send_tweet(tweet_construct(handles,body,@survey))

      Survey.update(@survey.id, sent: 1)
      flash[:error] = "Survey Sent!"
      redirect to("/surveys/#{@survey.id}/send")
    else
      tweet_error(handles, body)
      redirect to("/send/#{@survey.id}/tweet")
    end
  else
    post_failure
    erb :index
  end
end

get "/send/:survey_id/link" do
  if authorized?(params[:survey_id]) 
    @survey = current_survey(params[:survey_id])
    erb :'/send/send_link'
  else
    get_failure
    erb :index
  end
end

post "/send/:survey_id/link" do
  if authorized?(params[:survey_id])
    @survey = current_survey(params[:survey_id])
    flash[:error] = "Survey Sent!"
    erb :'/send/send_portal'
  else
    post_failure
    erb :index
   end
end

