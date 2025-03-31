Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: "sessions", registrations: "registrations"
  }
  namespace :api do
    namespace :v1 do
      resource :users, only: [ :show, :update ]
      resources :companies, only: [ :index, :create, :update ]
      resources :interviews, only: [ :index, :create, :update ]
      resources :meetings, only: [ :index, :create, :update ]
      resources :submissions, only: [ :index, :create, :update, :destroy ]
    end
  end
end