Rails.application.routes.draw do
  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  devise_for :users

  resources :users
  resources :subtasks
  resources :tasks
  resources :activities, concerns: :paginatable
  resources :projects
  resources :teams

  root 'welcome#welcome'

  get 'profile' => 'users#profile',         as: 'profile'
  
  get 'weekly_for_project_report/:project_id'  => 'reports#weekly_for_project_report',  as: 'weekly_for_project_report'
  get 'project_report/:project_id'  => 'reports#project_report',  as: 'project_report'
  get 'user_report/:user_id'        => 'reports#user_report',     as: 'user_report'
  get 'week_report'                 => 'reports#week_report',     as: 'week_report'
  get 'month_report'                => 'reports#month_report',    as: 'month_report'
  get 'year_report'                 => 'reports#year_report',     as: 'year_report'
  post 'new_week_report'            => 'reports#new_week_report', as: 'new_week_report'

  get '/version'                    => 'application#version'

  get '/check_import_file'         => 'activities#check_import_file', as: :check_import_file
  post '/upload_activities_file_url' => 'activities#upload_activities_file', as: :upload_activities_file
  post '/execute_import'             => 'activities#execute_import',    as: :execute_import

  # this must be the last line
  # backup route
  match '*path', via: :all, to: 'welcome#welcome'

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
