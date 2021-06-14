module Cor1440Gen
  module Concerns
    module Models
      module ActividadOrgsocial
        extend ActiveSupport::Concern

        included do

          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad', 
            foreign_key: 'actividad_id'
          belongs_to :orgsocial, class_name: 'Sip::Orgsocial',
            foreign_key: 'orgsocial_id'

        end # included
      end
    end
  end
end



