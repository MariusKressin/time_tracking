Rails.application.routes.draw do
  devise_for :user, path: '',
                    path_names: { sign_in: 'login', sign_out: 'logout' },
                    controllers: { registrations: 'users/registrations' }

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
end
