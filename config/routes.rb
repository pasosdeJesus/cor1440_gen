# encoding: UTF-8

Cor1440Gen::Engine.routes.draw do

  # Poner antes de resources :actividads
  get "/actividades/contar" => "actividades#contar", 
    as: :contar_actividades

  get "/actividades/contar_beneficiarios" => "actividades#contar_beneficiarios", 
    as: :contar_actividades_beneficiarios

  resources :actividades, path_names: { new: 'nueva', edit: 'edita' }
  
  get "/actividades/:id/fichaimp" => "actividades#fichaimp", 
    as: :actividad_fichaimp
  get "/actividades/:id/fichapdf" => "actividades#fichapdf", 
    as: :actividad_fichapdf


  get "/actividadespf/" => "proyectosfinancieros#actividadespf", 
    as: :actividadespf

  resources :actividadespf, only: [:new, :destroy], path_names: {new: 'nueva'}

  resources :campostind, path_names: { new: 'nuevo', edit: 'edita' }

  resources :efectos, path_names: { new: 'nuevo', edit: 'edita' }

  resources :indicadorespf, only: [:new, :destroy]

  resources :informes, path_names: { new: 'nuevo', edit: 'edita' }
  get "/informes/:id/impreso" => "informes#impreso", 
    as: :impresion

  resources :mindicadorespf, path_names: { new: 'nuevo', edit: 'edita' }
  get "/api/actividades/relacionadas" => "actividades#relacionadas",
    as: :relacionadas
  get "/api/cor1440gen/medir_indicador" => "mindicadorespf#medir_indicador", 
    as: :medir_indicador
  get "/api/cor1440gen/duracion" => "proyectosfinancieros#duracion", 
    as: :duracion 
  get "/objetivospf/" => "proyectosfinancieros#objetivospf", 
    as: :objetivospf
  resources :objetivospf, only: [:new, :destroy]

  resources :pmsindicadorpf, only: [:new, :destroy]

  get '/proyectofinanciero/copia/:proyectofinanciero_id' =>
    'proyectosfinancieros#copia',
    as: :copia_proyectofinanciero

  get "/proyectosfinancieros/validar" => "proyectosfinancieros#validar", 
    as: :validar_proyectosfinancieros
  resources :proyectosfinancieros, path_names: { new: 'nuevo', edit: 'edita' }
  get "/proyectosfinancieros/:id/fichaimp" => "proyectosfinancieros#fichaimp", 
    as: :proyectofinanciero_fichaimp
  get "/proyectosfinancieros/:id/fichapdf" => "proyectosfinancieros#fichapdf", 
    as: :proyectofinanciero_fichapdf


  resources :resultadospf, only: [:new, :destroy]

  #resources :tiposindicador, path_names: { new: 'nuevo', edit: 'edita' }

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
