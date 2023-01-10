# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Informeauditoria
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion

          belongs_to :proyectofinanciero,
            class_name: "Cor1440Gen::Proyectofinanciero",
            optional: false

          validates :detalle, length: { maximum: 5000 }
          validates :seguimiento, length: { maximum: 5000 }

          default_scope { order(:id) }

          campofecha_localizado :fecha

          validate :fecha_posterior_inicio
          def fecha_posterior_inicio
            if fecha &&
                proyectofinanciero &&
                proyectofinanciero.fechainicio &&
                fecha < proyectofinanciero.fechainicio
              errors.add(
                :fecha,
                "La fecha debe ser posterior a la de inicio",
              )
            end
          end

          def presenta_nombre
            detalle
          end
        end # included
      end
    end
  end
end
