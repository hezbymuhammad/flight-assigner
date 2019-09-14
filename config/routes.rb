Rails.application.routes.draw do
  post "/graphql", to: "graphql#execute"
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
