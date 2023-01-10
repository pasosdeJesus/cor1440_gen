# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Valorcampotind
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo

          belongs_to :campotind,
            class_name: "::Cor1440Gen::Campotind",
            optional: false

          validates :valor, length: { maximum: 5000 }

          def presenta_nombre
            r = "#{campotind.presenta_nombre}: "
            if !campotind.tipo || campotind.tipo == 1 || campotind.tipo == 2 ||
                campotind.tipo == 3
              r += "#{valor}"
            elsif campotind.tipo == 4
              r += valor.to_i == 0 ? "NO" : "SI"
            end
            r
          end
        end # included
      end
    end
  end
end
