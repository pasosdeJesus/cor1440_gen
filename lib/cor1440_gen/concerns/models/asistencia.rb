# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Asistencia
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo

          belongs_to :actividad,
            class_name: "Cor1440Gen::Actividad",
            validate: true,
            optional: false
          belongs_to :persona,
            class_name: "Msip::Persona",
            validate: true,
            optional: false
          accepts_nested_attributes_for :persona, reject_if: :all_blank
          belongs_to :rangoedadac,
            class_name: "Cor1440Gen::Rangoedadac",
            optional: true
          belongs_to :orgsocial,
            class_name: "Msip::Orgsocial",
            optional: true
          belongs_to :perfilorgsocial,
            class_name: "Msip::Perfilorgsocial",
            optional: true

          validates :actividad, presence: true
          validates :persona,
            presence: true,
            uniqueness: {
              scope: :actividad_id,
              message: "El listado de actividades no puede tener personas repetidas",
            }

          def evalua_campo(campo, menserr)
            case campo
            when "persona"
              persona
            else
              menserr = "Campo #{campo} no está en lista blanca de asistencia. "
              puts menserr
              nil
            end
          end
        end # included
      end
    end
  end
end
