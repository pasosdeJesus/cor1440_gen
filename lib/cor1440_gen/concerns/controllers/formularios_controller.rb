# frozen_string_literal: true

require "mr519_gen/concerns/controllers/formularios_controller"

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
              :caracterizacion,
            ]
          end

          def lista_params
            mr519_gen_params +
              [caracterizacion_ids: []] +
              [actividadtipo_ids: []]
          end
        end # included
      end
    end
  end
end
