Sse::Application.routes.draw do
  resources :messages do
    collection { get :events }
  end
end
