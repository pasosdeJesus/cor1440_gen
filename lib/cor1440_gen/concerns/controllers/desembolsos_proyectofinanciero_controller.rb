# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Controllers
      module DesembolsosProyectofinancieroController
        extend ActiveSupport::Concern

        included do
          def destroy
          end

          def create
          end

          private

          def prepara_desembolso_proyectofinanciero
            @proyectofinanciero = Cor1440Gen::Proyectofinanciero.new(
              desembolso: [
                Cor1440Gen::Desembolso.new,
              ],
            )
          end
        end # included
      end
    end
  end
end
