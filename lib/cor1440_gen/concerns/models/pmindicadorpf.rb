# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module Pmindicadorpf
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion

          campofecha_localizado :fecha
          campofecha_localizado :finicio
          campofecha_localizado :ffin

          belongs_to :mindicadorpf,
            class_name: "Cor1440Gen::Mindicadorpf",
            optional: false

          has_many :datointermedioti_pmindicadorpf,
            class_name: "Cor1440Gen::DatointermediotiPmindicadorpf",
            foreign_key: "pmindicadorpf_id",
            dependent: :delete_all
          accepts_nested_attributes_for :datointermedioti_pmindicadorpf,
            allow_destroy: true,
            reject_if: :all_blank
        end # included
      end
    end
  end
end
