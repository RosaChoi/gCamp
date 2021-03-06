Rails.application.routes.draw do
  resources :users
  resources :projects do
    resources :tasks
    resources :memberships
  end

  root 'welcome#home'

  get 'about' => 'pages#about'
  get 'terms' => 'pages#terms'
  get 'faq'   => 'pages#faq'

  get '/sign-up' => 'registrations#new', as: :signup
  post '/sign-up' => 'registrations#create'
  get '/sign-in' => 'authentication#new', as: :signin
  post '/sign-in' => 'authentication#create'
  get '/sign-out' => 'authentication#destroy', as: :signout

end
