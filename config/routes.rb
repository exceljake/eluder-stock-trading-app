Rails.application.routes.draw do
  # Root Page
  root to: "pages#home"

  # Devise Routes
  devise_for :users, module: "users", skip: [:sessions]
  devise_scope :user do
    get "login" => "users/sessions#new", as: :new_user_session
    post "login" => "users/sessions#create", as: :user_session
    delete "logout" => "users/sessions#destroy", as: :destroy_user_session
    get "register" => "users/registrations#new", as: :register
    get ":role/profile/edit" => "users/registrations#edit", as: :user_edit
  end

  # Trader Routes
  scope "trader" do
    get "dashboard" => "traders#dashboard", as: :trader_dashboard

    get "portfolio" => "traders#portfolio", as: :trader_portfolio
    post "portfolio" => "portfolio#create", as: :create_portfolio

    get "transactions" => "traders#transactions", as: :trader_transactions
    get "transactions/:id" => "transactions#trader_show", as: :trader_transaction
    post "transactions/:id/buy" => "transactions#buy", as: :buy_transaction
    post "transactions/:id/sell" => "transactions#sell", as: :sell_transaction

    get "portfolio/properties/:id" => "properties#show", as: :property 
  end

  # Admin Routes
  scope "admin" do
    get "dashboard" => "admins#dashboard", as: :admin_dashboard
    
    resources :accounts
    patch "accounts/:id/approve" => "accounts#approve", as: :approve_account

    get "transactions" => "admins#transactions", as: :admin_transactions
    get "transactions/:id" => "transactions#admin_show", as: :admin_transaction
  end

  # Shared Routes
  scope "market" do
    resources :stocks, only: [:index, :show]
    post "stocks" => "stocks#check", as: :check_stock
  end
end