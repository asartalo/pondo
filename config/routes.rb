Rails.application.routes.draw do
  mount JasmineRails::Engine => '/jasmine' if defined?(JasmineRails)
  devise_for :users, skip: [:registrations],
                     controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  devise_scope :user do
    get '', :to => 'home#index', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root to: 'home#index'
  get 'welcome', to: 'welcome#index'

  resources :ledgers, only: [:create, :show], param: :ledger_id

  resources :ledgers, only: [] do
    resources :incomes
    resources :expenses
    resources :subscribers
  end

  resources :subscriptions, only: [:show] do
    member do
      get :subscribe
    end
  end

  if Rails.env != 'production'
    resources :nitrolinks, only: [:index] do
      collection do
        get 'link1'
        get 'redirecting'
        get 'redirected'
        get 'changing'
        get 'error_500'
        post 'changing_post'
        post 'blank'
      end
    end
  end
end
