Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: 'home#index'
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
  post '/settings', to: 'settings#update', as: 'config'
  put '/settings', to: 'settings#update'
  patch '/settings', to: 'settings#update'

  # Export
  get '/export', to: 'export#index'
  get '/export/csv', to: 'export#csv'
  get '/export/pdf', to: 'export#pdf'
end
