Rails.application.routes.draw do
  
  resources :user_relations

  resources :memberships

  get 'pages/membership_not_paid'
  get 'pages/send_questionaire'
  post 'pages/email_questionaire'
  get 'pages/generate_pedigree'

  get 'patient/destroy' => 'patient#destroy' , :as => 'patient_destroys'
  get 'patient/destroy/:id(.:format)' => 'patient#destroy', :as => 'patient_destroy'
  get 'patient/family_tree' => 'patient#family_tree' , :as => 'patient_family_trees'
  get 'patient/family_tree/:id(.:format)' => 'patient#family_tree' , :as => 'patient_family_tree'
  get 'patient/survey_answers' => 'patient#survey_answers', :as => 'patient_survey_answerss'
  get 'patient/survey_answers/:id(.:format)' => 'patient#survey_answers', :as => 'patient_survey_answers'
  get 'patient/patient_survey'

  resources :patient
  resources :payments
  post 'payments/redirect_to_paypal'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    :registrations => "users/registrations"
  } do 
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :users

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # Routes For Rapid Fire Questionaire
  mount Rapidfire::Engine => "/rapidfire"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  devise_scope :user do
    root :to => 'devise/sessions#new'
    delete "/users/sign_out" => "devise/sessions#destroy"
  end

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
