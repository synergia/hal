Hal::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, ActiveAdmin::Devise.config.merge(:path_prefix => 'auth')

  # root :to => redirect("/admin")
end
