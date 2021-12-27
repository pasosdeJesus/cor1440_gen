module Cor1440Gen
  module Concerns
    module Models
      module ActividadareasActividad
        extend ActiveSupport::Concern

        included do
          belongs_to :actividad, class_name: "Cor1440Gen::Actividad", 
            optional: false
          belongs_to :actividadarea, class_name: "Cor1440Gen::Actividadarea", 
            optional: false
        end
      end
    end
  end
end

