Rails.application.routes.draw do

  resources :ds_classes

  resources :buddy_walks

  get 'articles/edit'

  get 'articles/update'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'static_pages#home'

  resources :events do
    resources :time_slots, only: [:create, :destroy]
    member do
      put 'register'
      put 'unregister'
    end
  end

  resources :buddy_walks do
    resources :time_slots, only: [:create, :destroy]
    member do
      put 'register'
    end
  end

  resources :ds_classes do
    resources :time_slots, only: [:create, :destroy]
    member do
      put 'register'
    end
  end

  get    'home'   => 'static_pages#home'
  get    'calendar' => 'static_pages#calendar'
  get    'edit_text_box' => 'static_pages#edit_text_box'
  get    'checkin' => 'users#checkin'
  get    'give_staff_role' => 'users#give_staff_role'
  get    'remove_staff_role' => 'users#remove_staff_role'

  get    'signup' => 'users#new'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get    'searchresults_events'     => 'events#search',        as: 'events_search'
  get    'searchresults_users'      => 'users#search',         as: 'users_search'
  get    'searchresults_classes'      => 'ds_classes#search',  as: 'classes_search'
  
  get    'events/:id/roster'        => 'events#show_roster',   as: 'roster_of_event'
  get    'events/:id/add_time_slot' => 'events#add_time_slot', as: 'add_time_slot_to_event'

  get    'buddy_walks/:id/roster'        => 'buddy_walks#show_roster',   as: 'roster_of_buddy_walks'
  get    'buddy_walks/:id/add_time_slot' => 'buddy_walks#add_time_slot', as: 'add_time_slot_to_buddy_walks'

  get    'ds_classes/:id/roster'        => 'ds_classes#show_roster',   as: 'roster_of_ds_class'
  get    'ds_classes/:id/add_time_slot' => 'ds_classes#add_time_slot', as: 'add_time_slot_to_ds_class'

  resources :users do
    member do
      get 'registrations' => 'users#show_registrations'
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :articles, only: [:edit, :update]

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