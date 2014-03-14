EventCircle::Application.routes.draw do

  devise_for :users,:skip => [:sessions], controllers: { sessions: "users/dash_board" }

   devise_scope :user do
         get '/home' => "devise/sessions#new", :as => :new_user_session
         post '/dash_board' => 'users/dash_board#create', :as => :user_session
         get '/sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
         get '/events_registered' => 'users/dash_board#events_attended', :as => :events_registered
         get '/events_published' => 'users/dash_board#events_published', :as => :events_published
         get '/events_for_publish' => 'users/dash_board#events_need_to_publish', :as => :events_for_publish
         get '/current_events' => 'users/dash_board#current_events', :as => :current_events
         get '/host' => 'users/dash_board#become_host', :as => :host
         get '/guest' => 'users/dash_board#become_guest', :as => :guest


  end
  match  '/about_us'   => "home#about", as: :about_us

  resources :events do
    member do
      get 'register'
      get 'publish'
    end
  end
  root :to => 'home#index'
 

  

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
