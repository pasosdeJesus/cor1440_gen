# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module ActividadOrgsocial
        extend ActiveSupport::Concern

        included do
          belongs_to :actividad,
            class_name: "Cor1440Gen::Actividad",
            optional: false
          belongs_to :orgsocial,
            class_name: "Msip::Orgsocial",
            optional: false
        end # included
      end
    end
  end
end
