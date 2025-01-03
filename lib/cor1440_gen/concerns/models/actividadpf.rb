# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Actividadpf
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion
          include Msip::FormatoFechaHelper

          belongs_to :actividadtipo,
            class_name: "Cor1440Gen::Actividadtipo",
            optional: true

          belongs_to :heredade,
            class_name: "Cor1440Gen::Actividadpf",
            optional: true

          belongs_to :formulario,
            class_name: "Mr519Gen::Formulario",
            optional: true

          belongs_to :proyectofinanciero,
            class_name: "Cor1440Gen::Proyectofinanciero",
            optional: false

          belongs_to :resultadopf,
            class_name: "Cor1440Gen::Resultadopf",
            optional: false

          has_one :objetivopf,
            class_name: "Cor1440Gen::Objetivopf",
            through: :resultadopf

          has_and_belongs_to_many :actividad,
            class_name: "Cor1440Gen::Actividad",
            foreign_key: "actividadpf_id",
            association_foreign_key: "actividad_id",
            join_table: "cor1440_gen_actividad_actividadpf"

          has_many :actividadpf_mindicadorpf,
            dependent: :delete_all,
            class_name: "Cor1440Gen::ActividadpfMindicadorpf",
            foreign_key: "actividadpf_id"

          validates :nombrecorto,
            presence: true,
            length: { maximum: 15 },
            format: {
              without: /\s/,
              message: "No usar espacio en código de actividad",
            }
          validates :titulo, length: { maximum: 255 }
          validates :descripcion, length: { maximum: 5000 }

          def presenta_id_larga
            r = ""
            if resultadopf
              if resultadopf.objetivopf
                r += resultadopf.objetivopf.numero
              end
              r += resultadopf.numero
            end
            r += nombrecorto
            r
          end

          def presenta_nombre
            presenta_id_larga + ": " + titulo
          end
        end # included
      end
    end
  end
end
