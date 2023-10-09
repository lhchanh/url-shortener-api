Rails.application.routes.draw do
  namespace :api do
    get 'authentication/authenticate'
    post '/register', to: 'registrations#create'
    post '/auth', to: 'sessions#authenticate'
    post '/shorten', to: 'urls#shorten'
    get '/original_url', to: 'urls#original_url'
  end
end
