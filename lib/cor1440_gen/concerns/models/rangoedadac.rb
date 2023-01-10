# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Rangoedadac
        extend ActiveSupport::Concern
        include Msip::Basica

        included do
          has_many :actividad_rangoedadac,
            dependent: :delete_all,
            foreign_key: "rangoedadac_id",
            class_name: "::Cor1440Gen::ActividadRangoedadac"
          has_many :actividad,
            through: :actividad_rangoedadac,
            class_name: "::Cor1440Gen::Actividad"

          validates :nombre,
            presence: true,
            allow_blank: false,
            length: { maximum: 255 }
        end
      end
    end
  end
end
