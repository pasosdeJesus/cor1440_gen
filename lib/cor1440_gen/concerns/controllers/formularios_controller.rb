# encoding: UTF-8

require 'mr519_gen/concerns/controllers/formularios_controller'

module Cor1440Gen
  module Concerns
    module Controllers
      module FormulariosController

        extend ActiveSupport::Concern

        included do
          include Mr519Gen::Concerns::Controllers::FormulariosController

          def atributos_index
            [
              :id,
              :nombre,
              :nombreinterno,
              :campos,
              :caracterizacion
            ]
          end

            
          def lista_params
            mr519_gen_params +
            [ 
              :caracterizacion_ids => []
            ]
          end

          # Lista blanca de parametros
          #def formulario_params
          #  params.require(:formulario).permit(lista_params)
          #end


        end  # included


      end
    end
  end
end
