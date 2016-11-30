#require_relative "../../SPARK"
require_relative "../../Utility/Methods"

module API

  def self.list_people_uri
    "/people"
  end



  module REST
  module People

    def self.list(token, params={})
      Spark::Utility.spark_it(token, API.list_people_uri, params)
    end

    def self.get_person_details(token, id)
      Spark::Utility.spark_it(token, API.list_people_uri + "/#{id}")
    end

    def self.get_my_details(token)
      Spark::Utility.spark_it(token, API.list_people_uri + "/me")
    end


  end
  end

end