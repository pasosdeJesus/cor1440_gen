# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module ActividadActorsocial
        extend ActiveSupport::Concern

        included do

          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad', 
            foreign_key: 'actividad_id'
          belongs_to :actorsocial, class_name: 'Sip::Actorsocial',
            foreign_key: 'actorsocial_id'

        end # included
      end
    end
  end
end



