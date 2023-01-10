# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module ActividadAnexo
        extend ActiveSupport::Concern

        included do
          self.table_name = "cor1440_gen_actividad_anexo"

          belongs_to :actividad,
            class_name: "Cor1440Gen::Actividad",
            validate: true,
            inverse_of: :actividad_anexo,
            optional: false
          belongs_to :anexo,
            class_name: "Msip::Anexo",
            validate: true,
            optional: false
          accepts_nested_attributes_for :anexo, reject_if: :all_blank

          validates :actividad, presence: true
          validates :anexo, presence: true
        end
      end
    end
  end
end
