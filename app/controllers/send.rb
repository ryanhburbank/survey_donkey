
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
      flash[:error] = "Tweet Sent!"
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

get '/send/:survey_id/email' do
  if authorized?(params[:survey_id])
    @survey = Survey.find(params[:survey_id])
    @url = @survey.url
    @full_url = "http://localhost:9393/url/#{@url}"
    erb :'send/send_email'
  end
end

post '/send/:survey_id/email' do
  if authorized?(params[:survey_id])
    @survey = Survey.find(params[:survey_id])
    @url = @survey.url
    emails = params[:emails]
    subject = params[:subject]
    body = params[:body]
    mail = Mail.new do
      from "test@surveydonkey.com"
      to  emails
      subject subject
      body  body
    end

    mail.delivery_method :sendmail
    mail.deliver
    flash[:error] = "Email sent!"
    redirect to("/surveys/#{@survey.id}/send" )
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

