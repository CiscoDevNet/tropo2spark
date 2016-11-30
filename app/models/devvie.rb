require 'json'
require 'tropo-webapi-ruby'
require 'src/app/response'
require 'src/app/utils'
require 'src/Spark/Execute'

class Devvie < ApplicationRecord

  def self.index(rack_input)
    if rack_input.nil? || rack_input.empty?
      return App::Response.BadRequest
    end
    t = Tropo::Generator.new
    v = Tropo::Generator.parse rack_input
    response = initialText(v[:session][:initial_text])
    if response.status == 200
      t.say "Thanks for joining! Please check in with Devvie inside of the DevNet SE-Missions Possible Spark room by typing:\n Devvie agent <your_name> reporting in"
      t.say "Don't forget to mention Devvie to get his attention!"
    else
      t.say "Sorry, I had trouble processing your request"
    end
    t.response
  end

  private
  
  def self.initialText(email)
    email.delete!(' ')
    if App::Utils.valid_email?(email)
      id = Spark.get_user_id_by_email(email)
      if id.nil?
        return App::Response.new({body: {"error": "unable to get spark user id"}.to_json, status: 400 })
      else
        res = Spark.join_room(id, ENV["SPARK_ROOM_ID"])
        return App::Response.new({status: 200})
      end
    else
        return App::Response.new({body: {"error": "unable invalid email"}.to_json , status: 401 })
    end
  end

end