module Cor1440Gen
  module Concerns
    module Models
      module Caracterizacionpersona
        extend ActiveSupport::Concern

        included do

          belongs_to :respuestafor, class_name: 'Mr519Gen::Respuestafor', 
            foreign_key: 'respuestafor_id', optional: false
          accepts_nested_attributes_for :respuestafor,
            reject_if: :all_blank

          belongs_to :persona, 
            class_name: 'Sip::Persona',
            foreign_key: 'persona_id', optional: false

          belongs_to :ulteditor, 
            class_name: '::Usuario',
            foreign_key: 'ulteditor_id', optional: false

        end # included
      end
    end
  end
end



