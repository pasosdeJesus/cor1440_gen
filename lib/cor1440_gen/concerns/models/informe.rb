# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Informe
        extend ActiveSupport::Concern

        included do
          belongs_to :proyecto, class_name: 'Cor1440Gen::Proyecto',
            foreign_key: 'filtroproyecto', validate: true
          belongs_to :actividadarea, 
            class_name: 'Cor1440Gen::Actividadarea', 
            foreign_key: 'filtroactividadarea', validate: true
          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero', 
            foreign_key: 'filtroproyectofinanciero', validate: true

          validates :titulo, presence: true
          validates :filtrofechaini, presence: true
          validates :filtrofechafin, presence: true

          def new(*args, &block)
            byebug
            super(*args, block)
          end
        end

      end
    end
  end
end
