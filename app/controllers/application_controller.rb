class ApplicationController < Sinatra::Base
  # helpers ApplicationHelper

  # set folder for templates to ../views, but make the path absolute
  set :views, File.expand_path('../../views', __FILE__)

  # don't enable logging when running tests
  configure :production, :development do
    enable :logging
  end

  get '/' do
    erb :index
  end

  post '/phone/new' do
    phone = Phone.create(number: params[:phone])
    game = Game.new
    game.phone_id = phone.id
    game.save
    message = "Welcome to Trivia Time! Are you ready to play? Type 'quit' at anytime to end the game, otherwise, type 'play'."
    send_sms(phone.number, message)
    erb :welcome
  end

  post '/receive_sms' do
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
end