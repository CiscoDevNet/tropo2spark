#require_relative "../../SPARK"
require_relative "../../Utility/Methods"

module API

  def self.list_memberships_uri
    "/memberships"
  end



  module REST
  module Memberships

    def self.list(token, params={})
      Spark::Utility.spark_it(token, API.list_memberships_uri, params)
    end

    def self.create(token, params={})
      Spark::Utility.create_spark(token, API.list_memberships_uri, params)
    end

    def self.get_details(token, id)
      Spark::Utility.spark_it(token, API.list_memberships_uri + "/#{id}")
    end

    def self.update(token, id, params={})
      Spark::Utility.update_spark(token, API.list_memberships_uri + "/#{id}", parmams)
    end

    def self.delete(token, id)
      Spark::Utility.delete_spark(token, API.list_memberships_uri + "/#{id}")
    end


  end
  end

end