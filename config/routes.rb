Bsboll::Application.routes.draw do
  devise_for :players

  root :to => 'startpage#index'
end
