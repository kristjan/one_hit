OneHit::Application.routes.draw do
  resources :sites, :path => '/' do
    resources :quips

    collection do
      get :random
    end
  end

  resources :users

  root :to => "sites#index"
end
