Rails.application.routes.draw do
  scope :oauth do
    get 'request_auth', to: 'auth#request_auth', as: 'request_auth'
    get 'process_auth', to: 'auth#process_auth', as: 'process_auth'
  end
end
