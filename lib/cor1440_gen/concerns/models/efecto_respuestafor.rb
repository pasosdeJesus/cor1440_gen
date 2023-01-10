# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module EfectoRespuestafor
        extend ActiveSupport::Concern

        included do
          belongs_to :respuestafor,
            class_name: "Mr519Gen::Respuestafor",
            optional: false
          belongs_to :efecto,
            class_name: "Cor1440Gen::Efecto",
            optional: false
        end
      end
    end
  end
end
