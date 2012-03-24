Actions::Application.routes.draw do

  get "actions/create"

  root :to => "home#index"

  resources :templates, except: [:new, :edit] do
    resources :items, only: [:create, :update, :show, :destroy]
    resources :publications, only: [:index, :create, :show], shallow: true do
      namespace :export do
        resources :actions, only: [:create]
      end
    end
  end

  resources :projects, only: [] do
    resources :actions, only: [:index] do
      resources :actions, only: [:index]
    end
  end

  devise_for :users
  resources :users, only: [:show]
end
