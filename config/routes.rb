Rails.application.routes.draw do
  resources :items
  devise_for :users,
              controllers: {
                sessions: 'sessions',
                registrations: 'registrations'
              }
  
end
