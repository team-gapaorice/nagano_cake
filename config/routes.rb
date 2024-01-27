Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: 'public/registrations',
  sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: 'admin/sessions'
  }

  scope module: 'public' do
    root 'homes#top', as: 'top'
    get 'about' => 'homes#about'

    resources :items, only: [:index, :show]

    get 'customers/mypage' => 'customers#show'
    get 'customers/mypage/edit' => 'customers#edit'
    patch 'customers/mypage' => 'customers#update'
    get 'customers/confirm' => 'customers#confirm'
    get 'customers/withdrawal' => 'customers#withdrawal'

    resources :delivery_destinations, except: [:new, :show]

    resources :cart_items, only: [:index, :destroy, :create,:update]
    get 'cart_items/destroy_all' => 'cart_items#destroy_all'

    resources :orders, only: [:new, :create, :index, :show]
    get 'order/confirm' => 'orders#confirm'
    get 'order/thanks' => 'orders#thanks'
  end

  namespace :admin do
    root 'homes#top', as: 'top'

    resources :items, except: [:destroy]

    resources :genres, except: [:new, :show, :destroy]

    resources :customers, except: [:new, :create, :destroy]

    resources :oder, only: [:show, :update]

    resources :order_details, only: [:update]
  end

end