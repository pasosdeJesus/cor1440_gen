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

      def new
        @registro = clase.constantize.new
        @registro.nombre = 'A'
        @registro.fechacreacion = Date.today
        @registro.save!(validate: false)
        redirect_to cor1440_gen.edit_admin_actividadtipo_path(@registro)
      end

      def genclase
        'M'
      end

      def actividadtipo_params
        params.require(:actividadtipo).permit(
          *atributos_form + [:campoact_attributes => [
            :id, :nombrecampo, :tipo, :ayudauso, :_destroy ]
          ])
      end
    end
  end
end
