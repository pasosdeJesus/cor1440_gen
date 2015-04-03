# encoding: UTF-8
module Cor440Gen
  module Admin
    class OficinasController < BasicasController
      before_action :set_oficina, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Cor440Gen::Oficina
  
      def clase 
        "Cor440Gen::Oficina"
      end
  
      def set_oficina
        @basica = Oficina.find(params[:id])
      end
  
      def oficina_params
        params.require(:oficina).permit(*atributos_form)
      end
  
    end
  end
end
