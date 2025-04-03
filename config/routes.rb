Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: "sessions", registrations: "registrations"
  }
  namespace :api do
    namespace :v1 do
      resources :counts, only: [ :index ]
      resources :dashboard, only: [ :index ]
      resources :companies, only: [ :index, :show, :create, :update ]
      resources :interviews, only: [ :index, :create, :update, :destroy ]
      resources :meetings, only: [ :index, :create, :update, :destroy ]
      resources :submissions, only: [ :index, :create, :update, :destroy ]
      resource  :users, only: [ :show, :update ]
    end
  end
end