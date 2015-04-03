# encoding: UTF-8

require 'sivel2_gen/concerns/models/acto'

module Sivel2Sjr
  module Concerns
    module Models
      module Acto
        extend ActiveSupport::Concern
        include Sivel2Gen::Concerns::Models::Acto

        included do
          has_one :actosjr, class_name: 'Sivel2Sjr::Actosjr',
            foreign_key: "id_acto", dependent: :destroy, inverse_of: :acto
          accepts_nested_attributes_for :actosjr
        end

        module ClassMethods
        end

      end
    end
  end
end
