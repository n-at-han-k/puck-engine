# frozen_string_literal: true

PuckEngine::Engine.routes.draw do
  root to: "pages#index"
  
  resources :pages, only: [:index, :show]
  get "/p/:slug", to: "pages#by_slug", as: :page_by_slug
  
  resources :editor, controller: "editor" do
    member do
      patch :update
    end
  end
  
  resources :components, only: [:index, :show], defaults: { format: :json }
end
