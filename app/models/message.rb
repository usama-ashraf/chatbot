class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  enum type: {bot: "Bot", user: "User"}
end
