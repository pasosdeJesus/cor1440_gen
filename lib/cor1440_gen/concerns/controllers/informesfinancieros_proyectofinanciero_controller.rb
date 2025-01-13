module Cor1440Gen
  module Concerns
    module Controllers
      module InformesfinancierosProyectofinancieroController
        extend ActiveSupport::Concern

        included do
          def destroy
          end

          def create
          end

          private

          def prepara_informefinanciero_proyectofinanciero
            @proyectofinanciero = Cor1440Gen::Proyectofinanciero.new(
              informefinanciero: [
                Cor1440Gen::Informefinanciero.new
              ]
            )
          end

        end # included

      end
    end
  end
end

