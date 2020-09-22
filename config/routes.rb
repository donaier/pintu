Rails.application.routes.draw do
  scope "(:locale)" do
    devise_for :users
    get 'welcome/index'

    scope '/admin' do
      resources :users do
        patch :enable, on: :member
        get :add_role, on: :member
        get :revoke_role, on: :member
      end

      get :messages, controller: 'users', path: '/my/messages'
      get :my_show, controller: 'users', path: '/my/profile'
      get :my_edit, controller: 'users', path: '/my/profile/edit'
    end
  end

  get '/:locale' => 'welcome#index'
  root to: 'welcome#index'
end
