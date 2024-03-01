Rails.application.routes.draw do
  devise_for :users
  resources :events, only: [:index] do
    collection do
      post 'create_event'
    end
  end
end
