# encoding: UTF-8

Cor1440Gen::Engine.routes.draw do

  resources :actividades, path_names: { new: 'nueva', edit: 'edita' }
  
  get "/actividades/:id/fichaimp" => "actividades#fichaimp", 
    as: :actividad_fichaimp
  get "/actividades/:id/fichapdf" => "actividades#fichapdf", 
    as: :actividad_fichapdf

  get "/actividadespf/" => "proyectosfinancieros#actividadespf", 
    as: :actividadespf
  resources :actividadespf, only: [:new, :destroy]

  resources :camposact, path_names: { new: 'nuevo', edit: 'edita' }

  resources :campostind, path_names: { new: 'nuevo', edit: 'edita' }

  resources :indicadorespf, only: [:new, :destroy]

  resources :informes, path_names: { new: 'nuevo', edit: 'edita' }
  get "/informes/:id/impreso" => "informes#impreso", 
    as: :impresion

  resources :mindicadorespf, path_names: { new: 'nuevo', edit: 'edita' }
  get "/api/cor1440gen/mideindicador" => "mindicadorespf#mideindicador", 
    as: :mideindicador

  get "/objetivospf/" => "proyectosfinancieros#objetivospf", 
    as: :objetivospf
  resources :objetivospf, only: [:new, :destroy]
 
  get "/proyectosfinancieros/validar" => "proyectosfinancieros#validar", 
    as: :validar_proyectosfinancieros
  resources :proyectosfinancieros, path_names: { new: 'nuevo', edit: 'edita' }

  resources :resultadospf, only: [:new, :destroy]

  resources :tiposindicador, path_names: { new: 'nuevo', edit: 'edita' }

  namespace :admin do
    ab = ::Ability.new
    ab.tablasbasicas.each do |t|
      if (t[0] == "Cor1440Gen") 
        c = t[1].pluralize
        resources c.to_sym, 
          path_names: { new: 'nueva', edit: 'edita' }
      end
    end
  end

end
