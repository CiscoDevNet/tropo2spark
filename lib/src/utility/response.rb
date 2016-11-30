require 'json'
module Utility
  class Response

    def initialize(args={})
      @data = args
    end

    def json
      @data.to_json
    end

    def status
      @data[:status] || @data["status"]
    end


    def errors?
      if @data[:error] || @data["error"]
        return true
      else
        return false
      end
    end

    def errors
      @data[:error] || @data["error"]
    end


    def url
      @data[:url] || @data["url"]
    end


    def self.error(args)
      Utility::Response.new({
        "error": args
      })
    end



    def self.invalid_token
      Utility::Response.new({ "status": "invalid token" })
    end

  end
end
