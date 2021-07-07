Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "articles#index"

  resources :articles do
    # for the articles also have comments
    resources :comments
  end
end
