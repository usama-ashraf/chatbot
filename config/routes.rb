Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :users
  root "chats#index"
  resources :chats do
    resources :messages
  end
end
