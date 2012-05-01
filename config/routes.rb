Actions::Application.routes.draw do

  get "actions/create"

  root :to => "home#index"

  resources :templates, except: [:new, :edit] do
    resources :items, only: [:index, :create, :update, :show, :destroy]
    resources :publications, only: [:create, :show], shallow: true do
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

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:show] do
    resources :publications, only: [:index]
  end

  #match "users/:user_id/publications" => "publications#user_index"

end
