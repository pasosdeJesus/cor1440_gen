# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Caracterizacionpf
        extend ActiveSupport::Concern

        included do
          belongs_to :formulario,
            class_name: "Mr519Gen::Formulario",
            optional: false
          belongs_to :proyectofinanciero,
            class_name: "Cor1440Gen::Proyectofinanciero",
            optional: false
        end # included
      end
    end
  end
end
