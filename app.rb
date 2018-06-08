require "sinatra"
require "json"
require "securerandom"

require_relative "./random_status"
require_relative "./endpoint"

use Rack::Logger

helpers do
  def logger
    request.logger
  end
end

post Endpoint.instance.path do
  content_type :json

  request_id         = SecureRandom.uuid
  status_message_map = RandomStatus.instance.generate

  status status_message_map[:status]

  logger.info("request_id=#{request_id}, body=#{request.body}")
  logger.info("request_id=#{request_id}, scheme=#{request.scheme}")
  logger.info("request_id=#{request_id}, port=#{request.port}")
  logger.info("request_id=#{request_id}, request_method=#{request.request_method}")
  logger.info("request_id=#{request_id}, query_string=#{request.query_string}")
  logger.info("request_id=#{request_id}, content_length=#{request.content_length}")
  logger.info("request_id=#{request_id}, host=#{request.host}")
  logger.info("request_id=#{request_id}, referer=#{request.referer}")
  logger.info("request_id=#{request_id}, user_agent=#{request.user_agent}")
  logger.info("request_id=#{request_id}, cookies=#{request.cookies}")
  logger.info("request_id=#{request_id}, xhr?=#{request.xhr?}")
  logger.info("request_id=#{request_id}, url=#{request.url}")
  logger.info("request_id=#{request_id}, ip=#{request.ip}")

  {
    success: false,
    status:  status_message_map[:status],
    errors: { message: status_message_map[:message] }
  }.to_json
end
