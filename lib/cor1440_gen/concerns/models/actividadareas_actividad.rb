# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module ActividadareasActividad
        extend ActiveSupport::Concern

        included do
          belongs_to :actividad, class_name: "Sivel2Gen::Actividad"
          belongs_to :actividadarea, class_name: "Sivel2Gen::Actividadarea"
        end
      end
    end
  end
end

