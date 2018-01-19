class ConversationChannel < ApplicationCable::Channel
#  this subscribed method allows for a unique channel per id
  def subscribed
    stream_from "conversations-#{current_user.id}"
  end

#unsubscribed spreaks for itself 
  def unsubscribed
    stop_all_streams
  end

#speak creates a hash based on passed data and sends it to the front end with broadcase
# data from here can be seen on the front end
def speak(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el.values.first] = el.values.last
    end

    Message.create(message_params)
  end
end