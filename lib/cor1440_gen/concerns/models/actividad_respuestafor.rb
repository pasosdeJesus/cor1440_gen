# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module ActividadRespuestafor
        extend ActiveSupport::Concern

        included do

          belongs_to :respuestafor, class_name: 'Mr519Gen::Respuestafor', 
            foreign_key: 'respuestafor_id'
          accepts_nested_attributes_for :respuestafor,
            reject_if: :all_blank

          belongs_to :actividad, 
            class_name: 'Cor1440Gen::Actividad',
            foreign_key: 'actividad_id'

        end # included
      end
    end
  end
end



