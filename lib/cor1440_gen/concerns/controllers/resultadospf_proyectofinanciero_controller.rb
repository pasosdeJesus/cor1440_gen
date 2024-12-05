module Cor1440Gen
  module Concerns
    module Controllers
      module ResultadospfProyectofinancieroController
        extend ActiveSupport::Concern

        included do

          def create
          end

          def destroy
          end

          private

          def preparar_resultadopf_proyectofinanciero
            #o = Cor1440Gen::Objetivopf.new
            r = Cor1440Gen::Resultadopf.new
            @registro = @proyectofinanciero =
              Cor1440Gen::Proyectofinanciero.new(
                resultadopf: [r]
              )
          end

        end # included

      end
    end
  end
end
