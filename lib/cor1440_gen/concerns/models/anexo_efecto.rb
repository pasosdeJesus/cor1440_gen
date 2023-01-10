# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module AnexoEfecto
        extend ActiveSupport::Concern

        included do
          belongs_to :efecto,
            class_name: "Cor1440Gen::Efecto",
            optional: false
          belongs_to :anexo,
            class_name: "Msip::Anexo",
            validate: true,
            optional: false

          accepts_nested_attributes_for :anexo, reject_if: :all_blank

          validates :efecto, presence: true
          validates :anexo, presence: true
        end
      end
    end
  end
end
