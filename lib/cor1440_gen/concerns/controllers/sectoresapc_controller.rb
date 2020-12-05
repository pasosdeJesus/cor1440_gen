module Cor1440Gen
  module Concerns
    module Controllers
      module SectoresapcController
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          def clase 
            "Cor1440Gen::Sectorapc"
          end

          def set_sectorapc
            @basica = Cor1440Gen::Sectorapc.find(params[:id])
          end

          def atributos_index
            [
              "id", "nombre", "observaciones", "fechacreacion_localizada", 
              "habilitado"
            ]
          end

          def genclase
            'M'
          end

          def sectorapc_params
            params.require(:sectorapc).permit(*atributos_form)
          end

        end

      end
    end
  end
end
