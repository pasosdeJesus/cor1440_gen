# encoding: UTF-8
module Cor1440Gen
  module Admin
    class FinanciadoresController < Sip::Admin::BasicasController
      before_action :set_financiador, 
        only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource  class: Cor1440Gen::Financiador

      def clase 
        "Cor1440Gen::Financiador"
      end
  
      def set_financiador
        @basica = Financiador.find(params[:id])
      end
  
      def atributos_index
        ["id", "nombre", "observaciones", "fechacreacion", 
          "fechadeshabilitacion"]
      end
 
      def financiador_params
        params.require(:financiador).permit(*atributos_form)
      end
    end
  end
end

