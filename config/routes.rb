Rails.application.routes.draw do
  root to: 'home#index'

  get :search, controller: :home
  get 'schools/:id', to: 'schools#show', as: 'school'
  get 'state/:id', to: 'states#show'
  get 'cities/:id', to: 'states#cities'
  post 'submissions', to: 'submissions#create'
  get 'submissions', to: 'submissions#update'
  get 'allowed_administrations', to: 'administrations#allowed_administrations'
  get 'administration', to: 'administrations#show'
  get 'collect', to: 'collects#show'
  get 'form', to: 'forms#show'
  get 'clone_pipe', to: 'pipefy#clone_pipe'
  put 'quit_submission', to: 'submissions#quit'
  put 'collect_entry', to: 'collect_entries#update'
  put 'card_moved', to: 'pipefy#card_moved'
  get "update_contacts", to: "pipefy#update_contacts"

  # active admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  require 'sidekiq/web'
  authenticate :admin_user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
