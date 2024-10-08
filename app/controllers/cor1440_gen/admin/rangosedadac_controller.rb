# frozen_string_literal: true

module Cor1440Gen
  module Admin
    class RangosedadacController < Msip::Admin::BasicasController
      before_action :set_rangoedadac, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Cor1440Gen::Rangoedadac

      def clase
        "Cor1440Gen::Rangoedadac"
      end

      def set_rangoedadac
        @basica = Rangoedadac.find(params[:id])
      end

      def atributos_index
        [
          :id,
          :nombre,
          :limiteinferior,
          :limitesuperior,
          :observaciones,
          :fechacreacion_localizada,
          :habilitado,
        ]
      end

      def atributos_form
        atributos_index.map do |e|
          e == :fechacreacion_localizada ? :fechacreacion : e
        end
      end

      def genclase
        "M"
      end

      def rangoedadac_params
        params.require(:rangoedadac).permit(*atributos_form)
      end
    end
  end
end
