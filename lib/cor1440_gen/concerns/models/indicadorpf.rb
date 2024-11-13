# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Indicadorpf
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion
          include Msip::FormatoFechaHelper

          belongs_to :objetivopf,
            class_name: "Cor1440Gen::Objetivopf",
            optional: true
          belongs_to :proyectofinanciero,
            class_name: "Cor1440Gen::Proyectofinanciero",
            optional: true
          belongs_to :resultadopf,
            class_name: "Cor1440Gen::Resultadopf",
            optional: true
          belongs_to :tipoindicador,
            class_name: "Cor1440Gen::Tipoindicador",
            optional: true

          has_many :efecto,
            foreign_key: "indicadorpf_id",
            validate: true,
            dependent: :destroy,
            class_name: "Cor1440Gen::Efecto"

          has_many :mindicador,
            foreign_key: "indicadorpf_id",
            validate: true,
            dependent: :destroy,
            class_name: "Cor1440Gen::Mindicadorpf"

          validates :numero,
            presence: true,
            length: { maximum: 15 },
            format: {
              without: /\s/,
              message: "No usar espacio en código de resultado",
            }
          validates :indicador, presence: true, length: { maximum: 5000 }

          def presenta_codigo
            r = ""
            if resultadopf && resultadopf.objetivopf
              r = resultadopf.objetivopf.numero + resultadopf.numero
            elsif objetivopf
              r = objetivopf.numero
            end
            r += numero
            r
          end

          def presenta_nombre
            presenta_codigo + " " + indicador
          end
        end # included
      end
    end
  end
end
