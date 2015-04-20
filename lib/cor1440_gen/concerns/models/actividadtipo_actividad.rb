# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module ActividadtipoActividad
        extend ActiveSupport::Concern

        included do
          belongs_to :actividadtipo, class_name: 'Cor1440Gen::Actividadtipo'
          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad'
        end
      end
    end
  end
end

