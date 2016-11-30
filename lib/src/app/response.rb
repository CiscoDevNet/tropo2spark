module App
  class Response
    attr_reader :status, :body
    def initialize(args={})
      @status = args[:status] || args["status"]
      @body   = args[:body]   || args["body"]
    end

    def self.BadRequest
      self.new({status: 400})
    end

  end

end
