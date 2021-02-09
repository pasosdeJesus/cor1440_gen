# encoding: UTF-8
module Cor1440Gen
  module Admin
    class ProyectosController < Sip::Admin::BasicasController
      before_action :set_proyecto, 
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource  class: Cor1440Gen::Proyecto

      def clase 
        "Cor1440Gen::Proyecto"
      end

      def set_proyecto
        @basica = Proyecto.find(params[:id])
      end

      def atributos_index
        [
          "id", 
          "nombre", 
          "fechainicio_localizada",
          "fechacierre_localizada",
          "resultados",
          "observaciones",
          "fechacreacion_localizada"
        ]
      end

      def genclase
        return 'F';
      end

      def proyecto_params
        params.require(:proyecto).permit(*atributos_form)
      end

    end
  end
end
