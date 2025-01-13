module Cor1440Gen
  module Concerns
    module Controllers
      module InformesauditoriasProyectofinancieroController
        extend ActiveSupport::Concern

        included do
          def destroy
          end

          def create
          end

          private

          def prepara_informeauditoria_proyectofinanciero
            @proyectofinanciero = Cor1440Gen::Proyectofinanciero.new(
              informeauditoria: [
                Cor1440Gen::Informeauditoria.new
              ]
            )
          end

        end # included

      end
    end
  end
end

