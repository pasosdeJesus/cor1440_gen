# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module ActividadProyectosfinancierosController
        extend ActiveSupport::Concern

        included do
          before_action :prepara_actividad

          def destroy
          end

          def create
          end

          private

          def prepara_actividad
            @actividad = Cor1440Gen::Actividad.find_by(
              id: params[:actividad][:id].to_i,
            )
            if @actividad.actividad_proyectofinanciero.length == 0
              ap = Cor1440Gen::ActividadProyectofinanciero.new
              @actividad.actividad_proyectofinanciero << ap
            end
          end
        end # included
      end
    end
  end
end
