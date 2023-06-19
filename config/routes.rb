Rails.application.routes.draw do
  namespace :admin do
   root to: "homes#top"
   resources :genres, only: [:index]
  end
  
  # 会員側のルーティング設定
  scope module: :public do
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]
    resources :orders, only:[:new, :index, :show, :create] do
      collection do
        post 'confirm'
        get 'thanks'
      end
    end
    
    
  end
  
  #管理者用
  # URL /customers/sign_in...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  #顧客用
  devise_for :customers, skip: [:password], controllers: {
    registarations: "public/registarations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about',to: 'homes#about'
    resources :items, only: [:index, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
