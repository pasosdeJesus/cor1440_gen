# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Proyectofinanciero
        extend ActiveSupport::Concern
        include Sip::Basica

        included do

          belongs_to :financiador, class_name: 'Cor1440Gen::Financiador',
            foreign_key: "financiador_id", validate: true
          belongs_to :responsable, class_name: 'Usuario',
            foreign_key: "responsable_id", validate: true

          has_many :proyecto_proyectofinanciero, dependent: :delete_all,
            class_name: 'Cor1440Gen::ProyectoProyectofinanciero',
            foreign_key: 'proyectofinanciero_id'
          has_many :proyecto, through: :proyecto_proyectofinanciero,
            class_name: 'Cor1440Gen::Proyecto'

          has_many :actividad_proyectofinanciero, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadProyectofinanciero',
            foreign_key: 'proyectofinanciero_id'
          has_many :actividad, through: :actividad_proyectofinanciero,
            class_name: 'Cor1440Gen::Actividad'

          validates :nombre, presence: true, allow_blank: false, 
            length: { maximum: 1000 } 
          validates :compromisos, length: { maximum: 5000 }

        end
        
        class_methods do
          def human_attribute_name(atr)
            if (atr.to_s == "{:proyecto_ids=>[]}")
              "Proyectos"
            else
              super(atr)
            end
          end
        end

      end
    end
  end
end
