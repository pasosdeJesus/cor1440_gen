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
            @actividad = Cor1440Gen::Actividad.where(
              id: params[:actividad][:id].to_i
            ).take
            if @actividad.actividad_proyectofinanciero.length == 0
              @actividad.actividad_proyectofinanciero =  [
                Cor1440Gen::ActividadProyectofinanciero.new
              ]
            end
          end

        end # included

      end
    end
  end
end

