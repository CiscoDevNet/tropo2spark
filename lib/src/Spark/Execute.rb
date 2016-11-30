require 'src/utility/response'
require_relative 'Helper/Methods'
require 'json'

module Spark

  def self.send_image(email, message, url)
    id  = Helper::Methods.get_user_id_by_email(email)
    res = Helper::Methods.send_message(ENV["SPARK_TOKEN"], message, url, nil, id, nil)
  end

  def self.get_user_id_by_email(email)
    Helper::Methods.get_user_id_by_email(email)
  end

  def self.create_room(name)
    Helper::Methods.create_room(ENV["SPARK_TOKEN"], name)
  end

  def self.join_room(person_id, room_id)
    Helper::Methods.join_room(ENV["SPARK_TOKEN"], person_id, room_id)
  end

  def self.get_room(person_id, name)
    #Helper::Methods.get_room_id()
  end

end
