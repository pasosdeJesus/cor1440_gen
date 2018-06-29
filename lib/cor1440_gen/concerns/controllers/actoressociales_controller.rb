# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Controllers
      module ActoressocialesController 
        extend ActiveSupport::Concern

        included do
          include ActionView::Helpers::AssetUrlHelper

          before_action :set_actorsocial, 
            only: [:show, :edit, :update, :destroy]
          load_and_authorize_resource  class: Cor1440Gen::Actorsocial

          def clase 
            "Cor1440Gen::Actorsocial"
          end

          def set_actorsocial
            @basica = Cor1440Gen::Actorsocial.find(params[:id])
          end

          def atributos_index
            [
              "id", 
              "nombre"
            ] +
            #[ :sectoractor_ids => [] ] +
            [ #"personacontacto_id",
              "cargo",
              "correo",
              "telefono",
              "fax",
              "direccion",
              "pais_id",
              "web",
              "observaciones", 
              "fechacreacion_localizada", 
              "fechadeshabilitacion_localizada"
            ]
          end

          def genclase
            'M'
          end

          def actorsocial_params
            params.require(:actorsocial).permit(*atributos_form)
          end

        end

      end
    end
  end
end

