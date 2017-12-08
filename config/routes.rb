Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :kudos do
        post :challenge, on: :collection
        post :event, on: :collection
        get :install, on: :collection
      end
    end
  end
end
