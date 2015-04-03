# encoding: UTF-8
module Cor440Gen
  module Admin
    class RangosedadacController < Sip::BasicasController
      before_action :set_rangoedadac, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Cor440Gen::Rangoedadac
  
      def clase 
        "Cor440Gen::Rangoedadac"
      end
  
      def set_rangoedadac
        @basica = Rangoedadac.find(params[:id])
      end
  
      def atributos_index
        ["id", "nombre", "limiteinferior", "limitesuperior", 
          "fechacreacion", "fechadeshabilitacion"]
      end
  
      def genclase
        return 'M';
      end
  
      def rangoedadac_params
        params.require(:rangoedadac).permit(*atributos_form)
      end
  
    end
  end
end
