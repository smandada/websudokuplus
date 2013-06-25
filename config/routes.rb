Partner::Application.routes.draw do

  resources :sudokus  do
    collection { post :check }
  end
  root :to => "sudokus#index"
end
