ActionController::Routing::Routes.draw do |map|
  map.resources :hrs
  map.fresh_list '/freshers', :controller => 'hrs', :action => 'index'
  map.exp_list '/experiance', :controller => 'hrs', :action => 'experience_list'
  map.all_comments '/comments', :controller => 'admins',:action=>"list_comment"
  map.today_comment '/today_comment', :controller => 'admins',:action=>"comment"
  
  #map.connect 'Mail_to',:controller=>"admins",:action=>"send_mail" 
  map.resource :log, :controller => "logs", :member => "backup"

  map.resources :member_details
  map.resources :roles
  map.resources :languages
  map.signup '/signup', :controller => 'users', :action => 'create', :conditions => { :method => :post}
  map.signup '/signup', :controller => 'users', :action => 'new', :conditions => { :method => :get}
  map.resource :account, :controller => 'users'
  map.resource :user_session
  map.resources :users
  map.resources :password_resets, :only => [ :new, :create, :edit, :update ]
  map.reset_password '/reset_password', :controller => 'password_resets', :action => 'update',:conditions => { :method => :put}  
 
  map.register '/register/:activation_code', :controller => 'activations', :action => 'new'
  map.activate '/activate/:id', :controller => 'activations', :action => 'create'
  map.login '/login', :controller => 'user_sessions', :action => 'create', :conditions => { :method => :post}
  map.login '/login', :controller => 'user_sessions', :action => 'new', :conditions => { :method => :get}
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.index 'Login', :controller => "user_sessions", :action => "new" 
  map.root :index 
  

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
