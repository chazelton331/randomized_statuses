require 'sinatra'
require 'json'

get '/api/v2/auth' do
  content_type :json

  random_status = [401,429].sample
  message = case random_status
            when 401
              "Your email or password is incorrect."
            when 429
              "Too many requests."
            end

  status random_status

  {
    success: false,
    status:  random_status,
    errors: { message: message }
  }.to_json
end
