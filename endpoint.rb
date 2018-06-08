require "singleton"

class Endpoint
  include Singleton

  def path
    @path ||= ENV["ENDPOINT_PATH"]
  end
end
