Rails.application.routes.draw do
  devise_for :users, skip: [:registrations],
                     controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root to: 'home#index'
  get 'dashboard', to: 'dashboard#index'

  resources :ledgers, only: [:create, :show] do
    resources :incomes
  end
end
