# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module SectoresactoresController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase
            "Cor1440Gen::Sectoractor"
          end

          def set_sectoractor
            @basica = Cor1440Gen::Sectoractor.find(params[:id])
          end

          def atributos_index
            [
              "id",
              "nombre",
              "observaciones",
              "fechacreacion_localizada",
              "habilitado",
            ]
          end

          def genclase
            "M"
          end

          def sectoractor_params
            params.require(:sectoractor).permit(*atributos_form)
          end
        end
      end
    end
  end
end
