# encoding: UTF-8

require 'sivel2_gen/concerns/models/victima'

module Sivel2Sjr
  module Concerns
    module Models
      module Victima
        extend ActiveSupport::Concern
        include Sivel2Gen::Concerns::Models::Victima

        included do
          has_many :antecedente_victima, foreign_key: :id_victima, 
            validate: true, dependent: :destroy

          has_one :victimasjr, class_name: 'Sivel2Sjr::Victimasjr', 
            foreign_key: "id_victima", dependent: :destroy, validate: true, 
            inverse_of: :victima
          accepts_nested_attributes_for :victimasjr, reject_if: :all_blank,
            update_only: true
        end

        module ClassMethods
        end

      end
    end
  end
end
