Bsboll::Application.routes.draw do
  devise_for :players

  root :to => 'startpage#index'
  
  resources :clubs, :except => :show
  resources :courses, :except => :show
  resources :matches do
    member do
      put :prev_hole, :next_hole, :goto_hole
      get :results
      post :score
    end
  end
end
