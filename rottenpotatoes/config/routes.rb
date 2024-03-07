Rottenpotatoes::Application.routes.draw do
  resources :movies do
    member do
      get 'show_by_director'
    end
  end

  # Map '/' to be a redirect to '/movies'
  root to: redirect('/movies')
end
