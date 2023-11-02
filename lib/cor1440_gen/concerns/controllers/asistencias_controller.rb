# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module AsistenciasController
        extend ActiveSupport::Concern

        included do

          before_action :prepara_actividad

          def destroy
          end

          def create
          end

          private

          def prepara_actividad
            @actividad = Cor1440Gen::Actividad.new(
              asistencia: [Cor1440Gen::Asistencia.new]
            )
          end

        end # included
      end
    end
  end
end
