Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  post "encrypt" => "cryptography#encrypt", defaults: { format: "json" }
  post "decrypt" => "cryptography#decrypt", defaults: { format: "json" }
  post "sign" => "cryptography#sign", defaults: { format: "json" }
  post "verify" => "cryptography#verify"
end
