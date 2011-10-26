Bsboll::Application.routes.draw do
  devise_for :players

  root :to => 'startpage#index'
  
  resources :clubs, :except => :show
  resources :courses, :except => :show
  resources :matches
end
