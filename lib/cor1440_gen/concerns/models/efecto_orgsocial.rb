# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module EfectoOrgsocial
        extend ActiveSupport::Concern

        included do
          belongs_to :orgsocial,
            class_name: "Msip::Orgsocial",
            optional: false
          belongs_to :efecto,
            class_name: "Cor1440Gen::Efecto",
            optional: false
        end
      end
    end
  end
end
