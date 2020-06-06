Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  scope module: 'frontend' do
    root 'courses#index'

    resources :courses, only: %i[index show]

    resources :groups, only: %i[] do
      resources :students, only: %i[new create]
    end
  end
end
