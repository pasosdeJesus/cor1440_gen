# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Asistencia
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo 

          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad',
            validate: true, foreign_key: 'actividad_id'
          belongs_to :persona, class_name: 'Sip::Persona', validate: true,
            foreign_key: 'persona_id'
          accepts_nested_attributes_for :persona, reject_if: :all_blank
          belongs_to :rangoedadac, class_name: 'Cor1440Gen::Rangoedadac',
            foreign_key: 'rangoedadac_id'
          belongs_to :actorsocial, class_name: 'Sip::Actorsocial',
            foreign_key: 'actorsocial_id'
          belongs_to :perfilactorsocial, class_name: 'Sip::Perfilactorsocial',
            foreign_key: 'perfilactorsocial_id'

          validates :actividad, presence: true
          validates :persona, presence: true

        end # included
      end
    end
  end
end

