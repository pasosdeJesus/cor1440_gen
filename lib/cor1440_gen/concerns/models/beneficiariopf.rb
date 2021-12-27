module Cor1440Gen
  module Concerns
    module Models
      module Beneficiariopf
        extend ActiveSupport::Concern

        included do

          belongs_to :persona, class_name: 'Sip::Persona', 
            foreign_key: 'persona_id', optional: false
          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'proyectofinanciero_id', optional: false

        end # included
      end
    end
  end
end



