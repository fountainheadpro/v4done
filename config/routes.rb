Actions::Application.routes.draw do

  root :to => "home#index"

  resources :templates, except: [:new, :edit] do
    resources :items, only: [:create, :update, :show, :destroy]
    resources :publications, only: [:index, :create, :show], shallow: true
  end
  resources :action_lists
  resources :comments
  resources :actions

  devise_for :users
  resources :users, :only => :show
end
