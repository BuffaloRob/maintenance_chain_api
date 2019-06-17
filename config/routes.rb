Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :users
      resources :items do
        resources :categories do
          resources :logs
        end
      end

      get 'user', to: 'users#show', as: 'user_show'
      post 'signup', to: 'users#create', as: 'user_signup'
      post 'login', to: 'users#login', as: 'user_login'
      get 'logout', to: 'users#logout', as: 'user_logout'
      get 'past_due', to: 'logs#past_due', as: 'past_due'

    end
  end

  root 'users#login'
end
