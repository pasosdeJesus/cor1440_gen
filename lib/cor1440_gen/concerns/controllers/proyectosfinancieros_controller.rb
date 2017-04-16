# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Controllers
      module ProyectosfinancierosController
        extend ActiveSupport::Concern
        #include Sip::ConsultasHelper

        included do
          before_action :set_proyectofinanciero, 
            only: [:show, :edit, :update, :destroy]
          load_and_authorize_resource  class: Cor1440Gen::Proyectofinanciero

          def clase 
            "Cor1440Gen::Proyectofinanciero"
          end

          def new_admin_basica_path(o)
            return new_proyectofinanciero_path()
          end

          def set_proyectofinanciero
            @basica = Proyectofinanciero.find(params[:id])
          end

          # Redefinimos destroy porque el de tablas basicas 
          # (i.e Sip::Admin::BasicasController que debe ser
          # papa de la clase que incluye a esta)
          # exije eliminar primero registros en tablas union
          def destroy
            super("", false)
          end

          def atributos_index
            [ "id", 
              "nombre" ] +
              [ :financiador_ids =>  [] ] +
              [ "fechainicio_localizada",
                "fechacierre_localizada",
                "responsable_id"
            ] +
            [ :proyecto_ids =>  [] ] +
            [ "compromisos", 
              "monto",
              "observaciones"
            ] 
          end

          # Genero del nombre (F - Femenino, M - Masculino)
          def genclase
            return 'M';
          end

          def proyectofinanciero_params
            params.require(:proyectofinanciero).permit(*atributos_form)
          end

        end # included

      end
    end
  end
end

