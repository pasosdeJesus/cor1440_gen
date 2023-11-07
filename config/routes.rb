# frozen_string_literal: true

Cor1440Gen::Engine.routes.draw do
  get "/actividad/copia/:actividad_id" =>
    "actividades#copia",
    as: :copia_actividad

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

  # resources :tiposindicador, path_names: { new: 'nuevo', edit: 'edita' }

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
