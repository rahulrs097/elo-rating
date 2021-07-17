Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, defaults: {format: :json}
  post 'users/post_result', to: 'users#post_result'
end
