OneHit::Application.routes.draw do
  resources :sites, :path => '/' do
    resources :quips
  end

  root :to => "sites#index"
end
