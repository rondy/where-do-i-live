Rails.application.routes.draw do
  post 'consult_cep', to: 'addresses#consult_cep'
  root 'addresses#form'
end
