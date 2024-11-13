# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Resultadopf
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion
          include Msip::FormatoFechaHelper

          belongs_to :objetivopf,
            class_name: "Cor1440Gen::Objetivopf",
            optional: false
          belongs_to :proyectofinanciero,
            class_name: "Cor1440Gen::Proyectofinanciero",
            optional: true

          has_many :actividadpf,
            dependent: :delete_all,
            class_name: "Cor1440Gen::Actividadpf",
            foreign_key: "resultadopf_id"
          has_many :indicadorpf,
            dependent: :delete_all,
            class_name: "Cor1440Gen::Indicadorpf",
            foreign_key: "resultadopf_id"

          validates :numero,
            presence: true,
            length: { maximum: 15 },
            format: {
              without: /\s/,
              message: "No usar espacio en código de resultado",
            }
          validates :resultado, presence: true, length: { maximum: 5000 }

          def presenta_nombre
            (objetivopf ? objetivopf.numero : "") + numero + " " + resultado
          end

          def codigo_completo
            (objetivopf ? objetivopf.numero : "") + numero
          end
        end # included
      end
    end
  end
end
