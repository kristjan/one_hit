OneHit::Application.routes.draw do
  resources :sites, :path => '/' do
    resources :quips

    collection do
      get :random
    end
  end

  resources :users do
    collection do
      get :authorize
    end
  end

  match '/auth/:provider/callback', :to => "users#authorize"

  root :to => "sites#index"
end
