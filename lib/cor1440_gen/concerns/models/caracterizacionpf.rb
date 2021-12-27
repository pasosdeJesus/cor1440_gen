module Cor1440Gen
  module Concerns
    module Models
      module Caracterizacionpf
        extend ActiveSupport::Concern

        included do

          belongs_to :formulario, class_name: 'Mr519Gen::Formulario', 
            foreign_key: 'formulario_id', optional: false
          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'proyectofinanciero_id', optional: false

        end # included
      end
    end
  end
end



