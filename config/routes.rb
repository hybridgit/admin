Rails.application.routes.draw do
  root 'riders#stats'

  get 'riders/stats'
  get 'riders/total_phone_numbers'
  get 'riders/total_sms_sent'
  get 'riders/successful_connections'

  get 'riders/map'
  get 'riders/map_total_phone_numbers'
  get 'riders/map_total_sms_sent'
  get 'riders/map_successful_connections'

  resources :permissions
  resources :roles do
    get "delete"
    resources :role_permissions, :as => :permissions
  end
  resources :users do
    resources :user_roles, :as => :roles do
      get "delete"
    end
    get "delete"
  end



  get '/login',  :to => 'sessions#new'
  get '/logout', :to => 'sessions#destroy'
  post '/sessions/create', :to => 'sessions#create'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
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
