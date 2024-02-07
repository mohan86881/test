Rails.application.routes.draw do
  resources :employees
   get '/tax_deduction' , to:'employees#tax_deduction'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
