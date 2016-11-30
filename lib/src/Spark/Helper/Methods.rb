require_relative '../API/REST/People'
require_relative '../API/REST/Messages'
require_relative '../API/REST/Rooms'
require_relative '../API/REST/Memberships'
require 'json'

module Spark
module Helper

  module Methods

    def self.get_user_id_by_email(email)
      params = {
        "email": email,
        "max": 1
      }
      results = []
      res = API::REST::People.list(ENV["SPARK_TOKEN"], params)
      res["items"].each do |person|
        results << person
      end
      results[0]["id"]
    end

    def self.send_message(token, text, files, room_id, to_person_id, to_person_email)
      params = {}
      params["text"]          = text            if text.nil?            == false
      params["files"]         = files           if files.nil?           == false
      params["roomId"]        = room_id         if room_id.nil?         == false
      params["toPersonId"]    = to_person_id    if to_person_id.nil?    == false
      params["toPersonEmail"] = to_person_email if to_person_email.nil? == false
      res = API::REST::Messages.create(token, params)
    end

    def self.create_room(token, title)
      res = API::REST::Rooms.create(token, title)
    end

    def self.join_room(token, person_id, room_id)
      params  = {
        "roomId": room_id,
        "personId": person_id
      }
      puts params
      res     = API::REST::Memberships.create(token, params)
      puts res
    end

    def self.get_room_id(token, room_name)
      res = API::REST::Rooms.list(token)
      if res.nil?
        return nil
      else
        res["items"].each do |room|
          if room["title"] == room_name
            return room["id"]
          end
        end
      end
      return nil
    end

  end




end
end
