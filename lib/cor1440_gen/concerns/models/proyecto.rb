# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Proyecto
        extend ActiveSupport::Concern
        include Sip::Basica

        included do

          has_many :proyecto_proyetofinanciero, dependent: :delete_all,
            class_name: 'Cor1440Gen::ProyectoProyectofinanciero',
            foreign_key: 'proyecto_id'
          has_many :proyectofinanciero, through: :proyecto_proyectofinanciero,
            class_name: 'Cor1440Gen::Proyectofinanciero'
        end
      end
    end
  end
end
