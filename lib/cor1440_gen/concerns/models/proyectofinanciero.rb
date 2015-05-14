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

          validates :nombre, presence: true, allow_blank: false
          validates :fechacreacion, presence: true, allow_blank: false

          def presenta(atr)
            case atr.to_s
            when "financiador_id" 
              Cor1440Gen::Financiador.find(self[atr]).nombre
            when "responsable_id"
              ::Usuario.find(self[atr]).nusuario
            when "{:proyecto_ids=>[]}"
              self.proyecto.map { |i| i.nombre }
            else
              self[atr].to_s
            end
          end

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
