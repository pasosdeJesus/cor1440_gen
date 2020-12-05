require 'heb412_gen/concerns/controllers/plantillahcm_controller'

module Cor1440Gen
  module Concerns
    module Controllers
      module PlantillahcmController

        extend ActiveSupport::Concern

        included do
          include Heb412Gen::Concerns::Controllers::PlantillahcmController

          def atributos_index
            [
              :id,
              :vista,
              :nombremenu,
              :ruta,
              :proyectofinanciero,
              :filainicial
            ]
          end

          def atributos_show
            [ :id, 
              :ruta,
              :fuente,
              :licencia,
              :vista,
              :nombremenu,
              :proyectofinanciero,
              :filainicial
            ]
          end  

          def lista_params_cor1440
            lista_params_heb412 + 
              [ :proyectofinanciero_ids => [] ]
          end

          def plantillahcm_params
            params.require(:plantillahcm).permit(lista_params_cor1440)
          end

        end  # included


      end
    end
  end
end
