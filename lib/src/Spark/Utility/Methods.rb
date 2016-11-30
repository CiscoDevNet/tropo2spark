require 'net/http'
require_relative '../SPARK'

module Spark
module Utility
    
    def self.ip
     "https://api.ciscospark.com/v1"
    end

    def self.apply_token(token)
      { 
        "Authorization" => "Bearer #{token}",
        "Content-Type"  => "application/json; charset=utf-8",
      }
    end

    def self.put_headers(token)
      { 
        "Authorization" => "Bearer #{token}",
        "Content-Type"  => "application/json",
      }
    end

    def self.set_uri(resource)
      URI(ip + resource)
    end

    def self.encode_url_params(base_url, args={})
      uri = base_url + "?"
      args.each do |k, v|
        unless v.nil?
          uri = uri + k.to_s + "=" + v.to_s + "&"
        end
      end
      uri[0...-1]
    end

    def self.swap_ip(uri, ip)
      url = URI(uri)
      url.host = ip
      url.to_s
    end

    def self.create_spark(token, uri, payload)
      spark = SPARK.new({
        uri: Utility.set_uri(uri),
        headers: Utility.apply_token(token),
        body: payload
      })
      spark.post!
      spark.results
    end

    # private factory method
    def self.spark_it(token, action, params={})
      base_uri = ip + "#{action}"  
      uri      = Utility.encode_url_params(base_uri, params)    
      spark = SPARK.new({
        uri: URI(uri),
        headers: apply_token(token)
      })
      spark.get!
      spark.results
    end

    def self.update_spark(token, action, payload)
      spark = SPARK.new({
        uri: Utility.set_uri(action),
        headers: Utility.apply_token(token),
        body: payload
      })
      spark.put!
      spark.results
    end

    def self.delete_spark(token, action)
      spark = SPARK.new({
        uri: Utility.set_uri(action),
        headers: Utility.apply_token(token)
      })
      spark.delete!
      spark.results
    end

end
end