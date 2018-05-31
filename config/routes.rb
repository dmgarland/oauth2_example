Rails.application.routes.draw do
  resources :repo, :only => :index do
    collection do
      get :oauth2_callback
    end
  end

  root 'repo#index'

end
