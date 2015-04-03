# encoding: UTF-8

require 'sivel2_gen/concerns/models/regionsjr'

module Sivel2Sjr
  module Concerns
    module Models
      module Regionsjr
        extend ActiveSupport::Concern
        include Sivel2Gen::Concerns::Models::Regionsjr

        included do
          has_many :casosjr, class_name: 'Sivel2Sjr::Casosjr',
            foreign_key: "id_regionsjr", validate: true
        end

        module ClassMethods
        end

      end
    end
  end
end
