# encoding: UTF-8

require 'sivel2_gen/concerns/models/estadocivil'

module Sivel2Sjr
  module Concerns
    module Models
      module Estadocivil 
        extend ActiveSupport::Concern
        include Sivel2Gen::Concerns::Models::Estadocivil

        included do
          has_many :victimasjr, class_name: "Sivel2Sjr::Victimasjr", 
            foreign_key: "id_estadocivil", validate: true
        end

        module ClassMethods
        end

      end
    end
  end
end
