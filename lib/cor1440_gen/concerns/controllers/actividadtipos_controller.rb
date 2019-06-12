# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Controllers
      module ActividadtiposController 
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          before_action :set_actividadtipo, only: [:show, :edit, :update, :destroy]
          load_and_authorize_resource class: Cor1440Gen::Actividadtipo

          def clase 
            "Cor1440Gen::Actividadtipo"
          end

          def set_actividadtipo
            @basica = Cor1440Gen::Actividadtipo.find(params[:id])
          end

          def atributos_index
            [:id, 
             :nombre, 
             :observaciones, 
             :formulario,
             :listadoasistencia,
             :fechacreacion_localizada, 
             :habilitado
            ]
          end

          def new
            @registro = clase.constantize.new
            @registro.nombre = 'A'
            @registro.fechacreacion = Date.today
            @registro.listadoasistencia = false
            @registro.save!(validate: false)
            redirect_to cor1440_gen.edit_admin_actividadtipo_path(@registro)
          end

          def genclase
            'M'
          end

          def actividadtipo_params
            l =  atributos_form - [:formulario] +
              [:formulario_ids => [] ] 
            params.require(:actividadtipo).permit(l)
          end

        end

      end
    end
  end
end

