# encoding: UTF-8
require_dependency "cor1440_gen/concerns/controllers/actividades_controller"

module Cor1440Gen
  class ActividadesController < Heb412Gen::ModelosController

    include Cor1440Gen::Concerns::Controllers::ActividadesController

          # GET /actividades/1/edit
          def edit
            edit_cor1440_gen
            @listadoasistencia = true
            render layout: 'application'
          end

  end
end
