# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module ObjetivospfProyectofinancieroController
        extend ActiveSupport::Concern

        included do
          def create
          end

          def destroy
          end

          private

          def preparar_objetivopf_proyectofinanciero
            @registro = @proyectofinanciero =
              Cor1440Gen::Proyectofinanciero.new(
                objetivopf: [
                  Cor1440Gen::Objetivopf.new,
                ],
              )
          end
        end # included
      end
    end
  end
end
