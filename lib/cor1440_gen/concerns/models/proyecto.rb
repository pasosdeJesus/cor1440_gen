# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Proyecto
        extend ActiveSupport::Concern
        include Msip::Basica

        included do
          has_many :informe,
            dependent: :delete_all,
            class_name: "Cor1440Gen::Informe",
            foreign_key: "filtroproyecto"

          has_and_belongs_to_many :actividad,
            class_name: "Cor1440Gen::Actividad",
            foreign_key: "proyecto_id",
            association_foreign_key: "actividad_id",
            join_table: "cor1440_gen_actividad_proyecto"

          has_and_belongs_to_many :proyectofinanciero,
            class_name: "Cor1440Gen::Proyectofinanciero",
            foreign_key: "proyecto_id",
            association_foreign_key: "proyectofinanciero_id",
            join_table: "cor1440_gen_proyecto_proyectofinanciero"

          campofecha_localizado :fechainicio
          campofecha_localizado :fechacierre

          validates :nombre,
            presence: true,
            allow_blank: false,
            length: { maximum: 1000 }
          validates :resultados, length: { maximum: 5000 }
        end
      end
    end
  end
end
