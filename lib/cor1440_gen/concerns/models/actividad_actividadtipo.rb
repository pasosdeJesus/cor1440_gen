module Cor1440Gen
  module Concerns
    module Models
      module ActividadActividadtipo
        extend ActiveSupport::Concern

        included do
          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad', 
            optional: false
          belongs_to :actividadtipo, class_name: 'Cor1440Gen::Actividadtipo', 
            optional: false
        end
      end
    end
  end
end

