require_dependency "cor1440_gen/concerns/controllers/actividades_controller"

module Cor1440Gen
  class ActividadesController < Heb412Gen::ModelosController

    include Cor1440Gen::Concerns::Controllers::ActividadesController

    before_action :set_actividad, 
      only: [:show, :edit, :update, :destroy],
      exclude: [:contar, :contar_beneficiarios]
    load_and_authorize_resource class: Cor1440Gen::Actividad
    
    # GET /actividades/1/edit
    def edit
      edit_cor1440_gen
      @listadoasistencia = true
      render layout: 'application'
    end

  end
end
