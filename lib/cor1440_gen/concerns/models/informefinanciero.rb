module Cor1440Gen
  module Concerns
    module Models
      module Informefinanciero
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo
          include Sip::Localizacion

          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero', 
            foreign_key: 'proyectofinanciero_id', optional: false

          validates :detalle, length: { maximum: 5000}
          validates :seguimiento, length: { maximum: 5000}

          default_scope { order(:id) }

          campofecha_localizado :fecha

          validate :fecha_posterior_inicio
          def fecha_posterior_inicio
            if fecha && 
              proyectofinanciero &&
              proyectofinanciero.fechainicio &&
              fecha < proyectofinanciero.fechainicio then
              errors.add(:fecha,
                         "La fecha debe ser posterior a la de inicio")
            end
          end

          def presenta_nombre
            self.detalle
          end

        end # included

      end
    end
  end
end
