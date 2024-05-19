Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#index'

  post '/hours/clear', to: 'hours#clear', as: 'clear_hours'
  resources :hours
  resources :topics
  resources :templates

  # Template Hour routes
  get '/templates/:template_id/hours/new', to: 'template_hours#new', as: 'new_template_hour'
  post '/templates/:template_id/hours', to: 'template_hours#create', as: 'template_hours'
  get '/templates/:template_id/hours/:id', to: 'template_hours#edit', as: 'edit_template_hour'
  put '/templates/:template_id/hours/:id', to: 'template_hours#update', as: 'template_hour'
  patch '/templates/:template_id/hours/:id', to: 'template_hours#update'
  delete '/templates/:template_id/hours/:id', to: 'template_hours#destroy', as: 'delete_template_hour'

  # Extra route for adding template to hours
  post '/templates/:id/add_to_hours', to: 'templates#add_to_hours'

  # Settings
  get '/settings', to: 'settings#index'
  post '/settings/update', to: 'settings#update'
  put '/settings/update', to: 'settings#update'
  patch '/settings/update', to: 'settings#update'

  # Export
  get '/export/html', to: 'hours#html', layout: 'pdf'
  get '/export/csv', to: 'hours#csv', as: 'export_csv'
  get '/export/pdf', to: 'hours#pdf', as: 'export_pdf'

  # Devise Custom Routes
  devise_scope :user do
    get '/sign_in', to: 'devise/sessions#new', as: 'new_user_session'
    post '/sign_in', to: 'devise/sessions#create', as: 'user_session'
    delete '/users/sign_out', to: 'devise/sessions#destroy', as: 'destroy_user_session'
    get '/password/new', to: 'devise/passwords#new', as: 'new_user_password'
    get '/password/edit', to: 'devise/passwords#edit', as: 'edit_user_password'
    patch '/account/password', to: 'devise/passwords#update', as: 'user_password'
    get '/sign_up', to: 'devise/registrations#new', as: 'new_user_registration'
    get '/account/edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
    patch '/users', to: 'devise/registrations#update', as: 'user_registration'
    put '/users/password', to: 'devise/passwords#update'
    post '/users/password', to: 'devise/passwords#create'
    put '/users', to: 'devise/registrations#update'
    delete '/users', to: 'devise/registrations#destroy'
    post '/users', to: 'devise/registrations#create'
  end
end
