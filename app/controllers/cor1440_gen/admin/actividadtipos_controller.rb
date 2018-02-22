# encoding: UTF-8
module Cor1440Gen
  module Admin
    class ActividadtiposController < Sip::Admin::BasicasController
      before_action :set_actividadtipo, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Cor1440Gen::Actividadtipo

      def clase 
        "Cor1440Gen::Actividadtipo"
      end

      def set_actividadtipo
        @basica = Actividadtipo.find(params[:id])
      end

      def atributos_index
        ["id", 
         "nombre", 
         "observaciones", 
         "campoact",
         "fechacreacion_localizada", 
         "fechadeshabilitacion_localizada"
        ]
      end

      def actividadtipo_params
        params.require(:actividadtipo).permit(
          *atributos_form + [:campoact_attributes => [
            :id, :nombrecampo, :ayudauso, :_destroy ]
          ])
      end
    end
  end
end
