Rails.application.routes.draw do
  get "menus", to: "menus#index" # GetAllMenu
  get "categories", to: "categories#index" #GetAllCategory
  get "menus/:id", to: "menus#show" #GetMenuById/:id
  get "categories/:category_id/menus", to: "menus#by_category" #GetMenuByCategory/:categoryId
  get "menus/:menu_id/options", to: "options#by_menu" #GetOptionsByMenu/:menuId

  # Swagger
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
