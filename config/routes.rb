OneHit::Application.routes.draw do
  resources :sites, :path => '/' do
    resources :quips

    collection do
      get :random
    end
  end

  root :to => "sites#index"
end
