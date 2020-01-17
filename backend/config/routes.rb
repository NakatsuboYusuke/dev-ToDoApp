Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :todos
      resources :users
    end
  end
end
