module Cor1440Gen
  module Concerns
    module Controllers
      module AnexosProyectofinancieroController
        extend ActiveSupport::Concern

        included do
          before_action :prepara_proyectofinanciero

          def destroy
          end

          def create
          end

          private

          def prepara_proyectofinanciero
            @proyectofinanciero = Cor1440Gen::Proyectofinanciero.new(
              anexo: [
                Msip::Anexo.new
              ]
            )
          end

        end # included

      end
    end
  end
end

