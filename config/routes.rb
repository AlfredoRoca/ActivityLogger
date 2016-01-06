# == Route Map
#
#            Prefix Verb   URI Pattern                           Controller#Action
#             users GET    /users(.:format)                      users#index
#                   POST   /users(.:format)                      users#create
#          new_user GET    /users/new(.:format)                  users#new
#         edit_user GET    /users/:id/edit(.:format)             users#edit
#              user GET    /users/:id(.:format)                  users#show
#                   PATCH  /users/:id(.:format)                  users#update
#                   PUT    /users/:id(.:format)                  users#update
#                   DELETE /users/:id(.:format)                  users#destroy
#     user_sessions GET    /user_sessions(.:format)              user_sessions#index
#                   POST   /user_sessions(.:format)              user_sessions#create
#  new_user_session GET    /user_sessions/new(.:format)          user_sessions#new
# edit_user_session GET    /user_sessions/:id/edit(.:format)     user_sessions#edit
#      user_session GET    /user_sessions/:id(.:format)          user_sessions#show
#                   PATCH  /user_sessions/:id(.:format)          user_sessions#update
#                   PUT    /user_sessions/:id(.:format)          user_sessions#update
#                   DELETE /user_sessions/:id(.:format)          user_sessions#destroy
#          subtasks GET    /subtasks(.:format)                   subtasks#index
#                   POST   /subtasks(.:format)                   subtasks#create
#       new_subtask GET    /subtasks/new(.:format)               subtasks#new
#      edit_subtask GET    /subtasks/:id/edit(.:format)          subtasks#edit
#           subtask GET    /subtasks/:id(.:format)               subtasks#show
#                   PATCH  /subtasks/:id(.:format)               subtasks#update
#                   PUT    /subtasks/:id(.:format)               subtasks#update
#                   DELETE /subtasks/:id(.:format)               subtasks#destroy
#             tasks GET    /tasks(.:format)                      tasks#index
#                   POST   /tasks(.:format)                      tasks#create
#          new_task GET    /tasks/new(.:format)                  tasks#new
#         edit_task GET    /tasks/:id/edit(.:format)             tasks#edit
#              task GET    /tasks/:id(.:format)                  tasks#show
#                   PATCH  /tasks/:id(.:format)                  tasks#update
#                   PUT    /tasks/:id(.:format)                  tasks#update
#                   DELETE /tasks/:id(.:format)                  tasks#destroy
#        activities GET    /activities(/page/:page)(.:format)    activities#index
#                   GET    /activities(.:format)                 activities#index
#                   POST   /activities(.:format)                 activities#create
#      new_activity GET    /activities/new(.:format)             activities#new
#     edit_activity GET    /activities/:id/edit(.:format)        activities#edit
#          activity GET    /activities/:id(.:format)             activities#show
#                   PATCH  /activities/:id(.:format)             activities#update
#                   PUT    /activities/:id(.:format)             activities#update
#                   DELETE /activities/:id(.:format)             activities#destroy
#          projects GET    /projects(.:format)                   projects#index
#                   POST   /projects(.:format)                   projects#create
#       new_project GET    /projects/new(.:format)               projects#new
#      edit_project GET    /projects/:id/edit(.:format)          projects#edit
#           project GET    /projects/:id(.:format)               projects#show
#                   PATCH  /projects/:id(.:format)               projects#update
#                   PUT    /projects/:id(.:format)               projects#update
#                   DELETE /projects/:id(.:format)               projects#destroy
#              root GET    /                                     activities#index
#             login GET    /login(.:format)                      user_sessions#new
#            logout POST   /logout(.:format)                     user_sessions#destroy
#           profile GET    /profile(.:format)                    users#profile
#    project_report GET    /project_report/:project_id(.:format) reports#project_report
#       user_report GET    /user_report/:user_id(.:format)       reports#user_report
#       week_report GET    /week_report(.:format)                reports#week_report
#   new_week_report POST   /new_week_report(.:format)            reports#new_week_report
#

Rails.application.routes.draw do  resources :users
  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  resources :user_sessions
  resources :subtasks
  resources :tasks
  resources :activities, concerns: :paginatable
  resources :projects
  resources :teams

  root 'activities#index'

  get 'login'   => 'user_sessions#new',     as: 'login'
  post 'logout' => 'user_sessions#destroy', as: 'logout'

  get 'profile' => 'users#profile',         as: 'profile'
  
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
  match '*path', via: :all, to: 'activities#index'

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
