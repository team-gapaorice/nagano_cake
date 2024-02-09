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
    patch 'customers/mypage' => 'customers#update'
    get 'customers/mypage/edit' => 'customers#edit'
    get 'customers/confirm' => 'customers#confirm'
    patch 'customers/withdrawal' => 'customers#withdrawal'

    resources :delivery_destinations, except: [:new, :show]

    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :destroy, :create,:update]


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