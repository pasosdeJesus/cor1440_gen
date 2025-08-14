# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module ActividadespfProyectofinancieroController
        extend ActiveSupport::Concern

        included do
          def create
          end

          def destroy
          end

          private

          def preparar_actividadpf_proyectofinanciero
            # o = Cor1440Gen::Objetivopf.new
            r = Cor1440Gen::Actividadpf.new
            @registro = @proyectofinanciero =
              Cor1440Gen::Proyectofinanciero.new(
                actividadpf: [r],
              )
            @col_resultados = Cor1440Gen::ProyectosfinancierosController
              .ini_resultados(+params[:proyectofinanciero][:id])
          end
        end # included
      end
    end
  end
end
