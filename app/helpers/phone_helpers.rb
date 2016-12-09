def send_sms(to, message)
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