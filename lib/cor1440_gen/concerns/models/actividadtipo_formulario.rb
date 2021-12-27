module Cor1440Gen
  module Concerns
    module Models
      module ActividadtipoFormulario
        extend ActiveSupport::Concern

        included do

          belongs_to :formulario, class_name: 'Mr519Gen::Formulario', 
            foreign_key: 'formulario_id', optional: false
          accepts_nested_attributes_for :formulario,
            reject_if: :all_blank

          belongs_to :actividadtipo, 
            class_name: 'Cor1440Gen::Actividadtipo',
            foreign_key: 'actividadtipo_id', optional: false

        end # included
      end
    end
  end
end



