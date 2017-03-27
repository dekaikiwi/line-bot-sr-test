Rails.application.routes.draw do
  get 'line_user/index'
  get 'line_user/:id' => 'line_user#show', as: 'line_user'
  post 'line_user/:id/send_message' => 'callback#send_message'

  post 'callback' => 'callback#callback'
  get 'page/index'

  root 'page#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
