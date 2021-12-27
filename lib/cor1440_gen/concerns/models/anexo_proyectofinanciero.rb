module Cor1440Gen
  module Concerns
    module Models
      module AnexoProyectofinanciero
        extend ActiveSupport::Concern

        included do

          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'proyectofinanciero_id', optional: false
          belongs_to :anexo, class_name: 'Sip::Anexo', 
            foreign_key: 'anexo_id', validate: true, optional: false

          accepts_nested_attributes_for :anexo, reject_if: :all_blank 

          validates :proyectofinanciero, presence: true
          validates :anexo, presence: true

        end # included

      end
    end
  end
end


