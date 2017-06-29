Rails.application.routes.draw do
  root to: 'application#index'
  scope :oauth do
    get 'request_auth', to: 'auth#request_auth', as: 'request_auth'
    get 'process_auth', to: 'auth#process_auth', as: 'process_auth'
  end

  get 'login/:id', to: 'login#login'
  get 'logout', to: 'login#logout'
  get 'current_user', to: 'login#show_current_user'

  scope :query do
    get 'products', to: 'query#products'
  end
end
