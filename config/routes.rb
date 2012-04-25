Actions::Application.routes.draw do

  get "actions/create"

  root :to => "home#index"

  resources :templates, except: [:new, :edit] do
    resources :items, only: [:index, :create, :update, :show, :destroy]
    resources :publications, only: [:index, :create, :show], shallow: true do
      namespace :export do
        resources :actions, only: [:create]
      end
    end
  end

  resources :deleted_templates, only: [:index, :show] do
    member do
      post 'restore'
    end
  end

  resources :projects, only: [:show] do
    resources :actions, only: [:update]
  end

  devise_for :users
  resources :users, only: [:show]
end
