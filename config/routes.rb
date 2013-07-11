RailsFileServer::Application.routes.draw do
  mount AttachmentService::API => '/attachments/api'
  resources :attachments
  root to: 'attachments#index'
end
