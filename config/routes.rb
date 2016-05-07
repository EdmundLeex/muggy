Rails.application.routes.draw do
  get 'static_pages/home'

  resources :orders, only: [:create]
end
