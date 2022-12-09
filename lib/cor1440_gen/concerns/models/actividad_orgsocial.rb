module Cor1440Gen
  module Concerns
    module Models
      module ActividadOrgsocial
        extend ActiveSupport::Concern

        included do

          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad', 
            foreign_key: 'actividad_id', optional: false
          belongs_to :orgsocial, class_name: 'Msip::Orgsocial',
            foreign_key: 'orgsocial_id', optional: false

        end # included
      end
    end
  end
end



