Rails.application.routes.draw do
  resources :invite_codes
  resources :guests

  root 'application#home'

  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}, controllers: {registrations: 'users/registrations'}
  match 'users/:id' => 'users#destroy', via: :delete, as: :admin_destroy_user
end
