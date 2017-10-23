Rails.application.routes.draw do
  root to: 'home#index'

  get :search, controller: :home
  get 'schools/:id', to: 'schools#show', as: 'school'
  get 'mec_schools/:id', to: 'mec_schools#show', as: 'mec_school'
  get 'state/:id', to: 'states#show'

  # active admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
