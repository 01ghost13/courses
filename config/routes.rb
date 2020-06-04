Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  scope module: 'frontend' do
    root 'courses#index'

    resources :courses, only: %i[index]
  end
end
