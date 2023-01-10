# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module ActividadpfMindicadorpf
        extend ActiveSupport::Concern

        included do
          belongs_to :actividadpf,
            class_name: "Cor1440Gen::Actividadpf",
            optional: false
          belongs_to :mindicadorpf,
            class_name: "Cor1440Gen::Mindicadorpf",
            optional: false
        end
      end
    end
  end
end
