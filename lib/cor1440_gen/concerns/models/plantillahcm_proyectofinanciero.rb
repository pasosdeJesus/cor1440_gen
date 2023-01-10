# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module PlantillahcmProyectofinanciero
        extend ActiveSupport::Concern

        included do
          belongs_to :plantillahcm,
            class_name: "Heb512Gen::Plantillahcm",
            optional: false
          belongs_to :proyectofinanciero,
            class_name: "Cor1440Gen::Proyectofinanciero",
            optional: false
        end # included
      end
    end
  end
end
