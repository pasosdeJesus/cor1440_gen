# frozen_string_literal: true

Cor1440Gen::Engine.routes.draw do
  get "/actividad/copiar/:id" =>
    "actividades#copiar",
    as: :copiar_actividad

  # Poner antes de resources :actividads
  get "/actividades/contar" => "actividades#contar",
    as: :contar_actividades

  get "/actividades/contar_beneficiarios" => "actividades#contar_beneficiarios",
    as: :contar_actividades_beneficiarios

  resources :actividades, path_names: { new: "nueva", edit: "edita" }

  get "/actividades/:id/fichaimp" => "actividades#fichaimp",
    as: :actividad_fichaimp
  get "/actividades/:id/fichapdf" => "actividades#fichapdf",
    as: :actividad_fichapdf

  get "/actividadespf/" => "proyectosfinancieros#actividadespf",
    as: :actividadespf

  resources :actividadespf, only: [:new, :destroy], path_names: { new: "nueva" }

  get "/actividadespf/conancestros" => "actividadespf#conancestros",
    as: :actividadespf_conancestros

  #get "/asistencia/nueva" => "actividades#nueva_asistencia",
  #  as: :nueva_asistencia

  resources :asistencia, only: [], param: :index do
    member do
      delete '(:id)', to: "asistencias#destroy", as: "eliminar"
      post '/' => "asistencias#create", as: "crear"
    end
  end

  resources :campostind, path_names: { new: "nuevo", edit: "edita" }

  get "/conteos/benefactividadpf" => "benefactividadpf#index",
    as: :benefactividadpf

  resources :efectos, path_names: { new: "nuevo", edit: "edita" }

  resources :indicadorespf, only: [:new, :destroy]

  resources :informes, path_names: { new: "nuevo", edit: "edita" }
  get "/informes/:id/impreso" => "informes#impreso",
    as: :impresion

  resources :mindicadorespf, path_names: { new: "nuevo", edit: "edita" }
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

  get "/proyectofinanciero/copia/:proyectofinanciero_id" =>
    "proyectosfinancieros#copia",
    as: :copia_proyectofinanciero

  get "/proyectosfinancieros/validar" => "proyectosfinancieros#validar",
    as: :validar_proyectosfinancieros
  resources :proyectosfinancieros, path_names: { new: "nuevo", edit: "edita" }
  get "/proyectosfinancieros/:id/fichaimp" => "proyectosfinancieros#fichaimp",
    as: :proyectofinanciero_fichaimp
  get "/proyectosfinancieros/:id/fichapdf" => "proyectosfinancieros#fichapdf",
    as: :proyectofinanciero_fichapdf

  resources :resultadospf, only: [:new, :destroy]

  resources :actividadpf_proyectofinanciero, only: [], param: :index do
    member do
      delete '(:id)', to: "actividadespf_proyectofinanciero#destroy", 
        as: "eliminar"
      post '/' => "actividadespf_proyectofinanciero#create", as: "crear"
    end
  end

  resources :indicadorpf_proyectofinanciero, only: [], param: :index do
    member do
      delete '(:id)', to: "indicadorespf_proyectofinanciero#destroy", 
        as: "eliminar"
      post '/' => "indicadorespf_proyectofinanciero#create", as: "crear"
    end
  end

  resources :indicadorobjetivo_proyectofinanciero, only: [], param: :index do
    member do
      delete '(:id)', to: "indicadoresobjetivo_proyectofinanciero#destroy", 
        as: "eliminar"
      post '/' => "indicadoresobjetivo_proyectofinanciero#create", as: "crear"
    end
  end

  resources :objetivopf_proyectofinanciero, only: [], param: :index do
    member do
      delete '(:id)', to: "objetivospf_proyectofinanciero#destroy",
        as: "eliminar"
      post '/' => "objetivospf_proyectofinanciero#create", as: "crear"
    end
  end

  resources :desembolso_proyectofinanciero, only: [], param: :index do
    member do
      delete '(:id)', to: "desembolsos_proyectofinanciero#destroy",
        as: "eliminar"
      post '/' => "desembolsos_proyectofinanciero#create", as: "crear"
    end
  end


  resources :proyectofinanciero_usuario, only: [], param: :index do
    member do
      delete '(:id)', to: "proyectofinanciero_usuarios#destroy", 
        as: "eliminar"
      post '/' => "proyectofinanciero_usuarios#create", as: "crear"
    end
  end

  resources :resultadopf_proyectofinanciero, only: [], param: :index do
    member do
      delete '(:id)', to: "resultadospf_proyectofinanciero#destroy", 
        as: "eliminar"
      post '/' => "resultadospf_proyectofinanciero#create", as: "crear"
    end
  end


  namespace :admin do
    ab = Ability.new
    ab.tablasbasicas.each do |t|
      next unless t[0] == "Cor1440Gen"

      c = t[1].pluralize
      resources c.to_sym,
        path_names: { new: "nueva", edit: "edita" }
    end
  end
end
