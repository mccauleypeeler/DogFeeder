Rails.application.routes.draw do
  root 'welcome#home'
  resources :cares
  post 'care', to: 'welcome#care'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
