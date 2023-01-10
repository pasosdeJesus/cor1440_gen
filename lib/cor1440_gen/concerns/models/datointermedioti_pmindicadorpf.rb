# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module DatointermediotiPmindicadorpf
        extend ActiveSupport::Concern

        included do
          belongs_to :datointermedioti,
            class_name: "Cor1440Gen::Datointermedioti",
            optional: false
          belongs_to :pmindicadorpf,
            class_name: "Cor1440Gen::Pmindicadorpf",
            optional: false

          validates_uniqueness_of :pmindicadorpf_id,
            scope: :datointermedioti_id

          validates :rutaevidencia, length: { maximum: 5000 }
        end # included
      end
    end
  end
end
