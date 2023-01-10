# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module ActividadActividadpf
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo

          belongs_to :actividad,
            class_name: "Cor1440Gen::Actividad",
            optional: false
          belongs_to :actividadpf,
            class_name: "Cor1440Gen::Actividadpf",
            optional: false
        end # included
      end
    end
  end
end
