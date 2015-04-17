# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Actividadarea
        extend ActiveSupport::Concern

        include Sip::Basica
        included do
          has_many :actividad_actividadarea, :dependent => :delete_all,
            class_name: 'Cor1440Gen::ActividadActividadarea'
          has_many :actividad, :through => :actividad_actividadarea,
            class_name: 'Cor1440Gen::Actividadarea'

          validates :nombre, presence: true, allow_blank: false
          validates :fechacreacion, presence: true, allow_blank: false
        end
      end
    end
  end
end

