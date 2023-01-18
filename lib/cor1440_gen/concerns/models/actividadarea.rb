# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Actividadarea
        extend ActiveSupport::Concern

        include Msip::Basica
        included do
          has_many :informe,
            dependent: :delete_all,
            class_name: "Cor1440Gen::Informe",
            foreign_key: "filtroactividadarea"

          has_many :actividadareas_actividad,
            dependent: :delete_all,
            class_name: "Cor1440Gen::ActividadareasActividad"
          has_many :actividad,
            through: :actividadareas_actividad,
            class_name: "Cor1440Gen::Actividad"
        end
      end
    end
  end
end
