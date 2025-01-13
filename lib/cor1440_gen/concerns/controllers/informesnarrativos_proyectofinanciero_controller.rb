module Cor1440Gen
  module Concerns
    module Controllers
      module InformesnarrativosProyectofinancieroController
        extend ActiveSupport::Concern

        included do
          def destroy
          end

          def create
          end

          private

          def prepara_informenarrativo_proyectofinanciero
            @proyectofinanciero = Cor1440Gen::Proyectofinanciero.new(
              informenarrativo: [
                Cor1440Gen::Informenarrativo.new
              ]
            )
          end

        end # included

      end
    end
  end
end

