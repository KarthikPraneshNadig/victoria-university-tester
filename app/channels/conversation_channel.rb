class ConversationChannel < ApplicationCable::Channel
  def subscribed
    stream from "conversations-#{current_user.id}"
  end
#The subscribe method creates a unique channel for each user because only the people using the channel should be notified 
#about events that are performed in it , also the sender and receiver get different information so we always need to notify 2 channels after we code.
  def unsubscribed
    stop_all_streams
  end
#removes all connections 

  def speak(data)
    message_params = data['message'].each_with_object({}) do |el, hash|
      hash[el.values.first]= el.values.last
    end 
  
    ActionCable.server.broadcast(
      "conversations-#{current_user.id}",
      message: message_params
    )
    #speak builds a hash that is based on passed data that sends information to the front end using action cable specified to the channel this is visible on the front ends received method
  end
end

