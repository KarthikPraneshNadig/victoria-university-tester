class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    sender = message.user
    recipient = message.conversation.opposed_user(sender)

    broadcast_to_sender(sender, message)
    broadcast_to_recipient(recipient, message)
  end

  private

  def broadcast_to_sender(user, message)
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      message: render_message(message, user),
      conversation_id: message.conversation_id
    )
  end

  def broadcast_to_recipient(user, message)
    ActionCable.server.broadcast(
      "conversations-#{user.id}",
      window: render_window(message.conversation, user),
      message: render_message(message, user),
      conversation_id: message.conversation_id
    )
  end

  def render_message(message, user)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message, user: user }
    )
  end

  def render_window(conversation, user)
    ApplicationController.render(
      partial: 'conversations/conversation',
      locals: { conversation: conversation, user: user }
    )
  end
end
#The perform method is the main method of this class. The code inside of it is started when you call the perform_later method. 
#the methods work by connecting with the specified channel and send a conversation_id and a html code using a partial in Rails 5 we render html code from any partial or view by calling ApplicationContoller.render