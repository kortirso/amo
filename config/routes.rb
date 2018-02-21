Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forms, only: %i[] do
        get :demo, on: :collection
      end
    end
  end

  root to: 'welcome#index'
end
