Rails.application.routes.draw do
  #管理者用
  # URL /customers/sign_in...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
   root to: "homes#top"
   get 'customers/:customer_id/orders' => 'orders#index', as: 'customer_orders'
   resources :items, only: [:index, :show, :new, :create, :edit, :update]
   resources :genres, only: [:index, :edit, :create, :update]
   resources :orders, only: [:show, :update]
   resources :order_details, only: [:update]
   resources :customers, only: [:index, :show, :edit, :update]
  end

 #顧客用
  devise_for :customers, skip: [:password], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 会員側のルーティング設定
  scope module: :public do
    root to: 'homes#top'
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    get 'customers/quit' => 'customers#quit', as: 'confirm_quit'
    put 'customers/information' => 'customers#update'
    patch 'customers/out' => 'customers#out', as: 'out_customer'
    get 'about',to: 'homes#about'
    resources :items, only: [:index, :show]
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
    resources :orders, only:[:new, :index, :show, :create] do
      collection do
        post 'confirm'
        get 'thanks'
      end
    end
    resources :cart_items, only:[:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end




  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
