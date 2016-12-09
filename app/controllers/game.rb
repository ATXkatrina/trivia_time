post '/game/new' do
  phone = Phone.new(number = params[:phone])
  message = "Welcome to Trivia Time!"
  # redirect '/send_sms'
end