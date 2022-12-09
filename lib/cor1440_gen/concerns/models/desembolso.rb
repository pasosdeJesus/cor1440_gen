module Cor1440Gen
  module Concerns
    module Models
      module Desembolso
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion

          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero', 
            foreign_key: 'proyectofinanciero_id', optional: false

          validates :detalle, length: { maximum: 5000}
          flotante_localizado :valorpesos
          validates :valorpesos, numericality:
            { greater_than: 0, less_than: 1000000000000000000 }

          campofecha_localizado :fecha

          validate :fecha_posterior_inicio 

          def fecha_posterior_inicio
            if fecha && proyectofinanciero && 
              proyectofinanciero.fechainicio && 
              fecha < (proyectofinanciero.fechainicio - 90) then
              errors.add(:fechaplaneada,
                         "La fecha planeada debe ser posterior a la fecha de inicio menos 90 días")
            end
          end

          default_scope { order(:id) }

        end # included

      end
    end
  end
end
