require "singleton"

class RandomStatus
  include Singleton

  def generate
    random_status = codes.sample

    case random_status
            when 401
              { status: 401, message: unauthorized_message }
            when 429
              { status: 429, message: too_many_requests_message }
            end
  end

  private

  def codes
    @codes ||= begin
      ENV["STATUS_CODES"].split(",").map(&:to_i)
    rescue
      [401,429]
    end
  end

  def unauthorized_message
    @unauthorized_message ||= ENV["UNAUTHORIZED_MESSAGE"]
  end

  def too_many_requests_message
    @too_many_requests_message ||= ENV["TOO_MANY_REQUESTS_MESSAGE"]
  end
end
