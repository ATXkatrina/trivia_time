enable :sessions

get '/' do
  erb :index
end

post '/receive_sms' do
  body = params['Body'].downcase
  content_type 'text/xml'
  phone = Phone.find_by(number: params["From"][2..-1])
  game = Game.find_by(phone_id: phone.id)
  response = Twilio::TwiML::Response.new do |r|
    if body == "play"
      data = game.play
      session[:question] = data["question"]
      session[:correct_answer] = data["correct_answer"]
      session[:poss_answers] = game.set_poss(data)
      r.Message "#{session[:question]}" + " " + "#{session[:poss_answers].join(", ")}"
    elsif body == "quit"
      r.Message "Goodbye!"
    elsif body == session[:correct_answer]
      r.Message "Nicely done!"
    else
      r.Message "Read you loud and clear!"
    end
  end
  response.to_xml
end

get '/session' do
  session.inspect
end

# post '/send_sms' do
#   to = params["to"]
#   message = params["body"]
#   send_sms(to, message)
# end
