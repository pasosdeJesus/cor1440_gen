# encoding: UTF-8
module Cor440Gen
  module Admin
    class ActividadareasController < Sip::BasicasController
      before_action :set_actividadarea, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Cor440Gen::Actividadarea
  
      def clase 
        "Cor440Gen::Actividadarea"
      end
  
      def set_actividadarea
        @basica = Actividadarea.find(params[:id])
      end
  
      def atributos_index
        ["id", "nombre", "observaciones", "fechacreacion", 
          "fechadeshabilitacion"]
      end
 
      def actividadarea_params
        params.require(:actividadarea).permit(*atributos_form)
      end
    end
  end
end
