# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Sectorapc
        extend ActiveSupport::Concern

        included do
          include Msip::Basica

          has_many :cor1440_gen_proyectofinanciero,
            class_name: "Cor1440Gen::Proyectofinanciero",
            foreign_key: "sectorapc_id",
            validate: true
        end # included
      end
    end
  end
end
