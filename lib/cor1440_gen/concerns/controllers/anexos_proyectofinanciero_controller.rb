module Cor1440Gen
  module Concerns
    module Controllers
      module AnexosProyectofinancieroController
        extend ActiveSupport::Concern

        included do
          def destroy
          end

          def create
          end

          private

          def prepara_anexo_proyectofinanciero
            @proyectofinanciero = Cor1440Gen::Proyectofinanciero.new(
              anexo: [
                Cor1440Gen::Anexo.new
              ]
            )
          end

        end # included

      end
    end
  end
end

