Rails.application.routes.draw do
  get 'users/show'

  # The priority is based upon order of creation: first created -> highest
  # priority.
  # See how all your routes lay out with "rake routes".

  # For devise authentication gem.
  devise_for :users
  resources :users, only: [:show]

  resources :users, only: [] do
    resources :topics, only: [:index]
  end

  resources :topics do
    resources :bookmarks, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :bookmarks, only: [] do
    resources :likes, only: [:index, :create, :destroy]
  end

  # App landing page.
  # get 'welcome/index'
  root 'welcome#index'

  # For Mailgun email api
  post :incoming, to: 'incoming#create'
  # For local dev testing.
  get  'incoming/create', to: 'incoming#create' if Rails.env.development?
  # post '/topics/:topic_id/bookmarks/incoming',        to: 'incoming#create_local', as: 'incoming_local' if Rails.env.development?
  # get  '/topics/:topic_id/bookmarks/incoming/create', to: 'incoming#create_local', as: 'incoming_local' if Rails.env.development?

  #---------------------------------------
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically)
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
