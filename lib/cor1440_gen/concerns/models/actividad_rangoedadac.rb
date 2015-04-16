# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module ActividadRangoedadac
        extend ActiveSupport::Concern

        included do
          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad'
          belongs_to :rangoedadac, class_name: 'Cor1440Gen::Rangoedadac'
        end
      end
    end
  end
end

