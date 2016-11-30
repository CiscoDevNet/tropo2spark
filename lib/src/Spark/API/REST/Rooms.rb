#require_relative "../../SPARK"
require_relative "../../Utility/Methods"

module API

  def self.rooms_uri
    "/rooms"
  end

  module REST
  module Rooms

    def self.list(token, params={})
      Spark::Utility.spark_it(token, API.rooms_uri, params)
    end

    def self.create(token, name)
      payload = {"title": name}
      Spark::Utility.create_spark(token, API.rooms_uri, payload)
    end

    def self.get(token, id)
      Spark::Utility.spark_it(token, API.rooms_uri + "/#{id}")
    end

    def self.update(token, id, name)
      payload = {"title": name}
      Spark::Utility.update_spark(token, API.rooms_uri + "/#{id}", payload)
    end

    def self.delete(token, id)
      Spark::Utility.delete_spark(token, API.rooms_uri + "/#{id}")
    end

  end
  end
end
