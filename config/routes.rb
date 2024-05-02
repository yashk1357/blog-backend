Rails.application.routes.draw do
  post 'accounts/signup'
  post 'accounts/login'
  get "up" => "rails/health#show", as: :rails_health_check

  resources :posts 
end
