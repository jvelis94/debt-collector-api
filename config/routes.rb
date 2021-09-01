Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, only: %w[show]
  end

  devise_for :users,
            controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
            }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
