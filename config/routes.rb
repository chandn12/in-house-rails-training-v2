Rails.application.routes.draw do
  authenticate :user, ->(user) { user.admin? } do
    mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  end

  get "home/index"
  get "/terms", to: "home#terms", as: :terms
  devise_for :users
  namespace :admin do
    resources :users
  end
  resources :genres
  resources :books do
    member do
      patch :undiscard
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index"
end
