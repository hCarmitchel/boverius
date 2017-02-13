Rails.application.routes.draw do
  resources :invite_codes, only: [:create, :new, :index, :edit, :update, :destroy]
  resources :guests

  root 'application#home'

  devise_for :users,
             path_names: { sign_in: 'login', sign_out: 'logout' },
             controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show, :edit, :update]

  match 'users/:id' => 'users#destroy', via: :delete, as: :admin_destroy_user

  get 'cities/:state', to: 'application#cities'
end
