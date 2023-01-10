# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module TiposmonedaController
        extend ActiveSupport::Concern

        included do
          def clase
            "Cor1440Gen::Tipomoneda"
          end

          def set_tipomoneda
            @basica = Tipomoneda.find(params[:id])
          end

          def atributos_index
            [
              :id,
              :nombre,
              :codiso4217,
              :simbolo,
              :pais_id,
              :observaciones,
              :fechacreacion_localizada,
              :habilitado,
            ]
          end

          def genclase
            "M"
          end

          def tipomoneda_params
            params.require(:tipomoneda).permit(*atributos_form)
          end
        end # included
      end
    end
  end
end
