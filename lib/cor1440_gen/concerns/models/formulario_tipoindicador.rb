# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module FormularioTipoindicador
        extend ActiveSupport::Concern

        included do
          belongs_to :formulario,
            class_name: "Mr519Gen::Formulario",
            optional: false
          accepts_nested_attributes_for :formulario,
            reject_if: :all_blank

          belongs_to :tipoindicador,
            class_name: "Cor1440Gen::Tipoindicador",
            optional: false
        end # included
      end
    end
  end
end
