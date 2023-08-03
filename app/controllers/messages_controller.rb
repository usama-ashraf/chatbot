class MessagesController < ApplicationController
  before_action :set_chat, only: [:new]
  def index
  end

  def new
    @message = Message.new
  end

  def create
    @message = current_user.messages.create(content: message_params[:content], chat_id: params[:chat_id])
    redirect_to chats_path
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:content, :user_type)
  end
end
