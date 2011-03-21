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

  %w[oops oops_js].each do |action|
    get "health/#{action}"
  end

  root :to => "sites#index"
end
