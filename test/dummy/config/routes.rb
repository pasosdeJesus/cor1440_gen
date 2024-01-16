# frozen_string_literal: true

Rails.application.routes.draw do
  devise_scope :usuario do
    get "sign_out" => "devise/sessions#destroy"
  end
  devise_for :usuarios, skip: [:registrations], module: :devise
  as :usuario do
    get "usuarios/edit" => "devise/registrations#edit",
      :as => "editar_registro_usuario"
    put "usuarios/:id" => "devise/registrations#update",
      :as => "registro_usuario"
  end
  resources :usuarios, path_names: { new: "nuevo", edit: "edita" }

  root "msip/hogar#index"

  namespace :admin do
    ab = Ability.new
    ab.tablasbasicas.each do |t|
      next unless t[0] == ""

      c = t[1].pluralize
      resources c.to_sym,
        path_names: { new: "nueva", edit: "edita" }
    end
  end

  mount Cor1440Gen::Engine, at: "/", as: "cor1440_gen"
  mount Mr519Gen::Engine => "/", as: "mr519_gen"
  mount Heb412Gen::Engine => "/", as: "heb412_gen"
  mount Msip::Engine, at: "/", as: "msip"
end
