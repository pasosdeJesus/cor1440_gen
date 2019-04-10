# encoding: UTF-8

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


          def plantillahcm_params
            params.require(:plantillahcm).permit(
              :filainicial,
              :fuente,
              :licencia,
              :nombremenu, 
              :ruta,
              :vista,
              :proyectofinanciero_ids => [],
              :campoplantillahcm_attributes => [
                :id,
                :nombrecampo,
                :columna,
                :_destroy
            ]
            )
          end

        end  # included

        class_methods do
          
          def valor_campo(c, r)
            byebug
            v = r[c.nombrecampo.to_sym].nil? ?
              r[c.nombrecampo] :
              r[c.nombrecampo.to_sym]
            return v
          end

        end

      end
    end
  end
end
