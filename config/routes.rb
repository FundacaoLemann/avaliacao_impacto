Rails.application.routes.draw do
  root to: 'home#index'

  get :search, controller: :home
  get 'schools/:id', to: 'schools#show', as: 'school'
  get 'state/:id', to: 'states#show'
  get 'cities/:id', to: 'states#cities'
  post 'submissions', to: 'submissions#create'
  get 'submissions', to: 'submissions#update'
  get 'allowed_administrations', to: 'form_options#allowed_administrations'

  # active admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
