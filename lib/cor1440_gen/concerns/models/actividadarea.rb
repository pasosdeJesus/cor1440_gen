# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Actividadarea
        extend ActiveSupport::Concern

        include Sip::Basica
        included do

          has_many :actividadareas_actividad, :dependent => :delete_all,
            class_name: 'Cor1440Gen::ActividadareasActividad'
          has_many :actividad, :through => :actividadareas_activid,
            class_name: 'Cor1440Gen::Actividad'

        end
      end
    end
  end
end

