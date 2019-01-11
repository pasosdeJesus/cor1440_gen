# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Beneficiariopf
        extend ActiveSupport::Concern

        included do

          belongs_to :persona, class_name: 'Sip::Persona', 
            foreign_key: 'persona_id'
          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'proyectofinanciero_id'

        end # included
      end
    end
  end
end



