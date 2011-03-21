OneHit::Application.routes.draw do
  resources :sites, :path => '/' do
    resources :quips

    collection do
      get :random
    end
  end

  resources :users

  %w[oops oops_js].each do |action|
    get "health/#{action}"
  end

  root :to => "sites#index"
end
