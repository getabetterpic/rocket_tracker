Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'test', to: 'test#secured'
      resources :motors, only: [:index]
      resources :kits, only: %i[index create show] do
        get 'all', on: :collection
      end
      resources :manufacturers, only: %i[index create]
    end
  end
end
