class ChatsController < ApplicationController
  before_action :authenticate_user!
  def index
    @current_user = current_user
    @chats = @current_user.chats.all.includes(:messages).sort_by { |chat| chat.messages.last&.created_at || Time.new(0) }.reverse
    @users = User.all
  end

  def create
    @chat = current_user.chats.create(chat_params)
    redirect_to chats_path
  end

  private

  def chat_params
    params.require(:chat).permit(:name)
  end
end
