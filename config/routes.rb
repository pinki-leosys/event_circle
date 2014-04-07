EventCircle::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users,:skip => [:sessions, :passwords], controllers: { sessions: "users/dash_board", passwords: "users/passwords",:registrations =>'users/registrations' }

   devise_scope :user do
         get '/home' => "devise/sessions#new", :as => :new_user_session
         post '/dash_board' => 'users/dash_board#create', :as => :user_session
         get '/sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
	       get '/user' => "users/registrations#new", :as => :sign_up
         #for guest 
         get '/events_attended' => 'users/dash_board#events_attended', :as => :events_attended
         get '/current_events' => 'users/dash_board#current_events', :as => :current_events
         get '/events_registered' => 'users/dash_board#events_attended'
         #for host
         get '/events_hosted' => 'users/dash_board#events_hosted', :as => :events_published
         get '/host_current_events' => 'users/dash_board#host_current_events', :as => :events_for_publish
         get '/saved_events' => 'users/dash_board#saved_events', :as => :events_for_publish
         get '/upcoming_events' => 'users/dash_board#upcoming_events', :as => :events_for_publish         
         get '/host' => 'users/dash_board#become_host', :as => :host
         get '/guest' => 'users/dash_board#become_guest', :as => :guest
         post '/users/password' => 'users/passwords#create', as: :user_password
         get '/users/password/new' => 'devise/passwords#new', as: :new_user_password
         get '/users/password/edit' => 'devise/passwords#edit', as: :edit_user_password
         put '/users/password' => 'devise/passwords#update'
         get  '/about_us_dashbord'     => "users/dash_board#about_us_dashbord", as: :about_us_dashbord
         get  '/host_dashboard'     => "users/dash_board#host_dashboard", as: :ec
         get  '/guest_dashboard'     => "users/dash_board#guest_dashboard", as: :ec
         get  '/user_contact' => "users/dash_board#user_contact", as: :contact_us
  end
  match  '/about_us'   => "home#about", as: :about_us
 # match  '/events'       => "home#events", as: :events
  match  '/contact_us'   => "home#contact", as: :contact_us
  match  '/host_event'     => "home#host_event", as: :host_event
  match  '/attend_event'     => "home#attend_event", as: :attend_event
  match  '/sponsor_event'     => "home#sponsor_event", as: :sponsor_event
  match "home/:id/activate_user" => "home#activate_user", :as => "activate_user"
    
  resources :events, :except => :index do
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
