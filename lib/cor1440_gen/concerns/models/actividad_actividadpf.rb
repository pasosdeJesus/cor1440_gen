module Cor1440Gen
  module Concerns
    module Models
      module ActividadActividadpf
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo

          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad', 
            foreign_key: 'actividad_id', optional: false
          belongs_to :actividadpf, class_name: 'Cor1440Gen::Actividadpf',
            foreign_key: 'actividadpf_id', optional: false
        end # included

      end
    end
  end
end



