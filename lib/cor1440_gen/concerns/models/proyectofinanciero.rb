# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Proyectofinanciero
        extend ActiveSupport::Concern
        include Sip::Basica
        include Sip::Localizacion

        included do
          campofecha_localizado :fechainicio
          campofecha_localizado :fechacierre

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

          has_many :financiador_proyectofinanciero, dependent: :delete_all,
            class_name: 'Cor1440Gen::FinanciadorProyectofinanciero',
            foreign_key: 'proyectofinanciero_id'
          has_many :financiador, through: :financiador_proyectofinanciero,
            class_name: 'Cor1440Gen::Financiador'

          has_many :informe, dependent: :delete_all,
            class_name: 'Cor1440Gen::Informe',
            foreign_key: 'filtroproyectofinanciero'

          validates :nombre, presence: true, allow_blank: false, 
            length: { maximum: 1000 } 
          validates :compromisos, length: { maximum: 5000 }

          validate :fechas_ordenadas
          def fechas_ordenadas
            if fechainicio && fechacierre && fechainicio > fechacierre
              errors.add(:fechacierre, 
                         "La fecha de cierre debe ser posterior a la de inicio")
            end
          end


        end
        
        class_methods do
          def human_attribute_name(atr, poromision = "")
            if (atr.to_s == "{:proyecto_ids=>[]}")
              "Proyectos"
            elsif (atr.to_s == "{:financiador_ids=>[]}")
              "Financiadores"
            else
              super(atr)
            end
          end
        end

      end
    end
  end
end
