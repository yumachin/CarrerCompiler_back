Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: "sessions", registrations: "registrations"
  }
  namespace :api do
    namespace :v1 do
      resource :users, only: [ :show, :update ]
      resource :companies, only: [ :create ]
      resources :interviews, only: [ :index, :create, :update ]
      resources :meetings, only: [ :index, :create, :update ]
    end
  end
end