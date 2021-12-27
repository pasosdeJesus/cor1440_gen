module Cor1440Gen
  module Concerns
    module Models
      module ActividadRangoedadac
        extend ActiveSupport::Concern

        included do
          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad', 
            optional: false
          belongs_to :rangoedadac, class_name: 'Cor1440Gen::Rangoedadac', 
            optional: false
        end
      end
    end
  end
end

