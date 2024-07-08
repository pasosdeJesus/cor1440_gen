# frozen_string_literal: true

module Cor1440Gen
  module Admin
    class ActividadareasController < Msip::Admin::BasicasController
      before_action :set_actividadarea, only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource class: Cor1440Gen::Actividadarea

      def clase
        "Cor1440Gen::Actividadarea"
      end

      def set_actividadarea
        @basica = Actividadarea.find(params[:id])
      end

      def atributos_index
        [
          :id,
          :nombre,
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

      def actividadarea_params
        params.require(:actividadarea).permit(*atributos_form)
      end
    end
  end
end
