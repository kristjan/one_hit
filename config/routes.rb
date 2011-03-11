OneHit::Application.routes.draw do
  resources :sites, :path => '/' do
    resources :quips

    collection do
      get :random
    end
  end

  resources :users

  match '/auth/:provider/callback', :to => "users#create"

  root :to => "sites#index"
end
