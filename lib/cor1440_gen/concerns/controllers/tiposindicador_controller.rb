module Cor1440Gen
  module Concerns
    module Controllers
      module TiposindicadorController
        extend ActiveSupport::Concern

        included do
          include Msip::FormatoFechaHelper

          def clase 
            "Cor1440Gen::Tipoindicador"
          end

          def set_tipoindicador
            @registro = Tipoindicador.find(params[:id])
          end

          def atributos_index
            [ :id, 
              :nombre,
              :medircon,
              :esptipometa,
              :espfuncionmedir,
              :datointermedioti,
              :formulario
            ]
          end

          def new
            @registro = clase.constantize.new
            @registro.nombre = 'I'
            @registro.fechacreacion = Date.today
            @registro.save!(validate: false)
            redirect_to cor1440_gen.edit_admin_tipoindicador_path(@registro)
          end

          def genclase
            return 'M';
          end

          def lista_params_cor1440_gen
            p = atributos_form - [:formulario, :datointermedioti] +
              [:formulario_ids => [] ] +
              [:datointermedioti_attributes => [ :nombre, :id, :_destroy ] ] 
            return p
          end

          def lista_params
            lista_params_cor1440_gen
          end

          def tipoindicador_params
            p = lista_params
            params.require(:tipoindicador).permit(p)
          end


        end # included

      end
    end
  end
end

