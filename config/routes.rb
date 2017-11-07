Rails.application.routes.draw do
  root to: 'home#index'

  get :search, controller: :home
  get 'schools/:id', to: 'schools#show', as: 'school'
  get 'state/:id', to: 'states#show'
  post 'submissions', to: 'submissions#create'
  put 'submissions', to: 'submissions#update'

  # active admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
