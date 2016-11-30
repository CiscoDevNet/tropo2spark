require_relative '../APIBase'
class SPARK < APIBase

    def post!
      Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do | http |
        @request =  Net::HTTP::Post.new(@uri)
        add_headers
        @request.body = @body.to_json
        @response = http.request @request
        if @response.code == "200" || @response.code == 200
          @results = JSON.parse(@response.body)
        else
          @results = {"status": @response.code}
        end
      end
    end

    def get!
      Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do | http |
        @request = Net::HTTP::Get.new(@uri)
        add_headers
        @response = http.request @request 
        if @response.code == "200" || @response.code == 200
          @results = JSON.parse(@response.body)
        else
          @results = {"status": @response.code}
        end
      end 
    end

    def put!
      Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do | http |
        @request =  Net::HTTP::Put.new(@uri)
        add_headers
        @request.body = @body.to_json
        @response = http.request @request
        if @response.code == "200" || @response.code == 200
          @results = JSON.parse(@response.body)
        else
          @results = {"status": @response.code}
        end
      end
    end

    def delete!
      Net::HTTP.start(@uri.host, @uri.port, :use_ssl => @uri.scheme == 'https') do | http |
        @request =  Net::HTTP::Delete.new(@uri)
        add_headers
        @response = http.request @request
        @results = {"status": @response.code}
      end
    end


end