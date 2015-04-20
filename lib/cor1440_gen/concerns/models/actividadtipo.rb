# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Actividadtipo
        extend ActiveSupport::Concern

        include Sip::Basica
        included do
          has_many :actividadtipo_actividad, :dependent => :delete_all,
            class_name: 'Cor1440Gen::ActividadtipoActividad'
          has_many :actividad, :through => :actividadtipo_actividad,
            class_name: 'Cor1440Gen::Actividadtipo'

          validates :nombre, presence: true, allow_blank: false
          validates :fechacreacion, presence: true, allow_blank: false
        end
      end
    end
  end
end

