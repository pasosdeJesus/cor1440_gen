# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module IndicadorespfProyectofinancieroController
        extend ActiveSupport::Concern

        included do
          def create
          end

          def destroy
          end

          private

          def preparar_indicadorpf_proyectofinanciero
            @registro = @proyectofinanciero =
              Cor1440Gen::Proyectofinanciero.new(
                indicadorpf: [
                  Cor1440Gen::Indicadorpf.new,
                ],
                indicadorobjetivo: [
                  Cor1440Gen::Indicadorpf.new,
                ],
              )
          end
        end # included
      end
    end
  end
end
