post '/phone/new' do
  phone = Phone.create(number: params[:phone])
  game = Game.new
  game.phone_id = phone.id
  game.save
  message = "Welcome to Trivia Time! Are you ready to play? Type 'quit' at anytime to end the game, otherwise, type 'play'."
  send_sms(phone.number, message)
  erb :welcome
end