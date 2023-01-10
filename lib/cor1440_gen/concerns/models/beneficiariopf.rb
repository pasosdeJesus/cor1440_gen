# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Beneficiariopf
        extend ActiveSupport::Concern

        included do
          belongs_to :persona,
            class_name: "Msip::Persona",
            optional: false
          belongs_to :proyectofinanciero,
            class_name: "Cor1440Gen::Proyectofinanciero",
            optional: false
        end # included
      end
    end
  end
end
