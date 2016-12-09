
get '/' do
  erb :index
end

post '/receive_sms' do
  content_type 'text/xml'
  response = Twilio::TwiML::Response.new do |r|
    r.Message "Read you loud and clear!"
  end
  response.to_xml
end

post '/send_sms' do

  to = params["to"]
  message = params["body"]
  client = Twilio::REST::Client.new(
    ENV["TWILIO_ACCOUNT_SID"],
    ENV["TWILIO_AUTH_TOKEN"]
    )


  client.messages.create(
    to: to,
    from: "+15122336886",
    body: message
    )
end