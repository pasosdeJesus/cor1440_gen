module Cor1440Gen
  module Concerns
    module Controllers
      module FinanciadoresController
        extend ActiveSupport::Concern

        included do

          def clase 
            "Cor1440Gen::Financiador"
          end

          def set_financiador
            @basica = Financiador.find(params[:id])
          end

          def atributos_index
            ["id", "nombre", "observaciones", "fechacreacion_localizada", 
             "habilitado"]
          end

          def genclase
            return 'M';
          end

          def financiador_params
            params.require(:financiador).permit(*atributos_form)
          end

        end # included

      end
    end
  end
end

