get '/' do
  erb :index
end

post '/receive_sms' do
  binding.pry
  body = params['Body'].downcase
  content_type 'text/xml'
  phone = Phone.find_by(number: params["From"][2..-1])
  game = Game.find_by(phone_id: phone.id)
  question_set = game.play
  response = Twilio::TwiML::Response.new do |r|
    if body == "play"
      round = Round.new
      round.question = question_set[0]
      round.answer = question_set[1]
      round.save
      r.Message round.question
    elsif body == "quit"
      r.Message "Goodbye!"
    else
      r.Message "Read you loud and clear!"
    end
  end
  response.to_xml
end

post '/send_sms' do
  to = params["to"]
  message = params["body"]
  send_sms(to, message)
end
