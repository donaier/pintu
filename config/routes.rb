Rails.application.routes.draw do
  devise_for :users
  scope '/admin' do
    resources :users do
      patch :enable, on: :member
    end
  end

  get 'welcome/index'

  root to: 'welcome#index'
end
