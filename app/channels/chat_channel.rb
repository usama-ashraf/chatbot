class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{current_user.id}"
  end

  def unsubscribed
  end

  def receive(data)
    message_content = data['message']
    chat_id = data['chat_id']
    user_id = current_user.id
    @message = Message.create(content: message_content, user_id: user_id, chat_id: chat_id, user_type: "User")
    generated_response = TextGenerationService.generate_text(message_content)
    @response = ActionCable.server.broadcast(
        "chat_channel_#{user_id}",
        {
            message: message_content,
            response: generated_response,
            chat_id: chat_id
        }
    )
    @message = Message.create(content: generated_response, user_id: user_id, chat_id: chat_id, user_type: "Bot")
  end
end
