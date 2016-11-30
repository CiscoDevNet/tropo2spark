require_relative 'APIBase'

class Client < APIBase

    def post!
      Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do | http |
        @request =  Net::HTTP::Post.new(@uri)
        add_headers
        @request.body = @body.to_json
        @response = http.request @request 
        @results = @response.body
      end
    end

    def get!
      Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do | http |
        @request = Net::HTTP::Get.new(@uri)
        add_headers
        @response = http.request @request 
        @results = @response.body
      end 
    end


    # generators that will return the results of an http request
    # post, get currently implemented
    def self.post_it(uri, headers, body)
      client = new_client(uri, headers, body) 
      client.post!
      client.results
    end

    def self.get_it(uri, headers, body)
      client = new_client(uri, headers, body) 
      client.get!
      client.results
    end

    # encodes params into a url (for get requests)
    def self.encode_url_params(base_url, args={})
      uri = base_url + "?"
      args.each do |k, v|
        unless v.nil?
          uri = uri + k.to_s + "=" + v.to_s + "&"
        end
      end
      uri[0...-1]
    end


    private

    def self.new_client(uri, headers, body)
      Client.new({
        uri: URI(uri),
        headers: headers,
        body: body
      })
    end

end