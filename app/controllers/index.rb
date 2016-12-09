
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

# fix this before next push
  account_sid = 'AC43244dcfbb8c4cdf258a76748a1f8c3d'
  auth_token = 'bd373e899538cf139268013d03934acc'


  to = params["to"]
  message = params["body"]

  client = Twilio::REST::Client.new(
    account_sid,
    auth_token
    # ENV["TWILIO_ACCOUNT_SID"],
    # ENV["TWILIO_AUTH_TOKEN"]
    )

  client.messages.create(
    to: to,
    from: "+15122336886",
    body: message
    )
end