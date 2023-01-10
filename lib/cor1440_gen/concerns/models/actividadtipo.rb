# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Actividadtipo
        extend ActiveSupport::Concern

        included do
          include Msip::Basica

          has_and_belongs_to_many :actividad,
            class_name: "Cor1440Gen::Actividadtipo",
            foreign_key: "actividadtipo_id",
            association_foreign_key: "actividad_id",
            join_table: "cor1440_gen_actividad_actividadtipo"

          has_and_belongs_to_many :formulario,
            class_name: "Mr519Gen::Formulario",
            foreign_key: "actividadtipo_id",
            association_foreign_key: "formulario_id",
            join_table: "cor1440_gen_actividadtipo_formulario"

          has_many :actividadpf,
            dependent: :delete_all,
            class_name: "Cor1440Gen::Actividadpf",
            foreign_key: "actividadtipo_id"
        end
      end
    end
  end
end
