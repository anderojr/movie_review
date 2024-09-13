Rails.application.routes.draw do
  resources :movies
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
}
  namespace :admin do
    resources :users, only: [:new, :create, :edit, :update]
  end

  root 'home#index'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
