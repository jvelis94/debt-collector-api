Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, only: %w[index show]
    resources :bills do
      resources :bill_items do 
        member do
          patch :increment_quantity
          patch :decrement_quantity
        end
      end
      resources :bill_recipients
    end

  end

  devise_for :users,
            controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
            }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
