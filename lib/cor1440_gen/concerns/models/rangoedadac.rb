# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Rangoedadac
        extend ActiveSupport::Concern
        include Sip::Basica

        included do

          has_many :actividad_rangoedadac, :dependent => :delete_all,
            class_name: '::Cor1440Gen::ActividadRangoedadac'
          has_many :actividad, :through => :actividad_rangoedadac,
            class_name: '::Cor1440Gen::Actividad'

          validates :nombre, presence: true, allow_blank: false, 
            length: { maximum: 255 } 

        end
      end
    end
  end
end

