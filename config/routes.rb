Rails.application.routes.draw do
  devise_for :users
  root "prototypes#index"
  # root "prototypes#index", path: "popular"

  # 『prototypes』以降に記述してしまうと、url打ち込み時に『/prototypes/:id』の方が先に来て、prototype#showへアクセスしてしまう。
  resources :newests, path: "prototypes/newest", only: :index

  # 『root』でindexを設定している為、下記にindexは不要となる。
  resources :prototypes, except: :index do
    resources :comments, only: :create
    resources :likes, only: [:create, :destroy]
  end

  # 通常のルーティング記載
  # resources :newests, only: :index
  # リソースベースで呼び出すコントローラ＆アクションに対して、URLを変更する場合
  # URLヘルパーの名前は変わらない。
  # resources :newests, path: "prototypes/newest", only: :index
  # 『controller:』の記述でも書くことが可能（URLヘルパーの名前は変わる）

  # namespace :prototypes do
  #   resources :newests, path: "newest", only: :index
  # end

  # 『param: :name』を記載することで、『:id』部分の変更が可能。
  # 下記の方法以外に、『to_param』をモデルに定義する方法もある。
  resources :tags, param: :name, only: [:index, :show]
  resources :users, only: [:show, :edit, :update]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
