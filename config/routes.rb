Rails.application.routes.draw do

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
    end
  end

  get    'home'   => 'static_pages#home'
  get    'calendar' => 'static_pages#calendar'
  get    'edit_text_box' => 'static_pages#edit_text_box'

  get    'signup' => 'users#new'
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get     'registration_confirmation'=> 'users#registration_confirmation', as: 'reg'

  get    'events/:id/roster'        => 'events#show_roster',   as: 'roster_of_event'
  get    'events/:id/add_time_slot' => 'events#add_time_slot', as: 'add_time_slot_to_event'

  resources :users do
    member do
      get 'registrations' => 'users#show_registrations'
    end
  end

  resources :account_activations, only: [:new, :create, :edit, :update]
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
