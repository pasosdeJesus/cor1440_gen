module Cor1440Gen
  module Concerns
    module Models
      module AnexoEfecto
        extend ActiveSupport::Concern

        included do
    
          belongs_to :efecto, class_name: 'Cor1440Gen::Efecto',
            foreign_key: 'efecto_id', optional: false
          belongs_to :anexo, class_name: 'Msip::Anexo', 
            foreign_key: 'anexo_id', validate: true, optional: false

          accepts_nested_attributes_for :anexo, reject_if: :all_blank 

          validates :efecto, presence: true
          validates :anexo, presence: true

        end
      end
    end
  end
end

