module App
  module Utils

    def self.valid_email? email
      if (email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
        true
      else
        false
      end
    end

    def self.devvie_spark_token
      require 'mongo'
      client = Mongo::Client.new(ENV['DEVVIE_MONGO_URL'])
      db     = client.database
      spark  = db[:spark]
      query  = {'username': 'DevNetBot'}
      cursor = spark.find(query)
      if cursor.nil?
        raise 'unable to retrieve access token for Devvie before cursor'
      else
        cursor.each do |doc|
          if not doc['accessToken'].nil?
            return doc['accessToken']
          end
        end
        raise 'unable to retrieve access token for Devvie at cursor'
      end
    end
    
  end
end
