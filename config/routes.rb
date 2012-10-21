Hal::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, ActiveAdmin::Devise.config

  root :to => redirect("/a")
end
