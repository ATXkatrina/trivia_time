# get '/' do
#   erb :index
# end

# post '/receive_sms' do
#   content_type 'text/xml'
#   response = Twilio::TwiML::Response.new do |r|
#     r.Message "Read you loud and clear!"
#   end
#   response.to_xml
# end

# post '/send_sms' do
#   to = params["to"]
#   message = params["body"]
#   send_sms(to, message)
# end