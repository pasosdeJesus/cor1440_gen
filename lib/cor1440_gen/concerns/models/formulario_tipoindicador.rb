module Cor1440Gen
  module Concerns
    module Models
      module FormularioTipoindicador
        extend ActiveSupport::Concern

        included do

          belongs_to :formulario, class_name: 'Mr519Gen::Formulario', 
            foreign_key: 'formulario_id'
          accepts_nested_attributes_for :formulario,
            reject_if: :all_blank

          belongs_to :tipoindicador, 
            class_name: 'Cor1440Gen::Tipoindicador',
            foreign_key: 'tipoindicador_id'

        end # included
      end
    end
  end
end



