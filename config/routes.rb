Actions::Application.routes.draw do

  root :to => "home#index"

  resources :templates, except: [:new, :edit] do
    resources :items, only: [:create, :update, :show, :destroy]
    resources :publications, only: [:index, :create, :show], shallow: true
  end
  resources :projects, only: [] do
    resources :actions, only: [:index]
  end

  devise_for :users
  resources :users, only: [:show]
end
