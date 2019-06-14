# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module AnexoEfecto
        extend ActiveSupport::Concern

        included do
    
          belongs_to :efecto, class_name: 'Cor1440Gen::Efecto',
            foreign_key: 'efecto_id'
          belongs_to :sip_anexo, class_name: 'Sip::Anexo', 
            foreign_key: 'anexo_id', validate: true

          accepts_nested_attributes_for :sip_anexo, reject_if: :all_blank 

          validates :efecto, presence: true
          validates :sip_anexo, presence: true

        end
      end
    end
  end
end

