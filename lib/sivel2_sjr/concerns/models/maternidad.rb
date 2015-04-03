# encoding: UTF-8

require 'sivel2_gen/concerns/models/maternidad'

module Sivel2Sjr
  module Concerns
    module Models
      module Maternidad 
        extend ActiveSupport::Concern
        include Sivel2Gen::Concerns::Models::Maternidad

        included do
          has_many :victimasjr, class_name: "Sivel2Sjr::Victimasjr", 
            foreign_key: "id_maternidad", validate: true
        end

        module ClassMethods
        end

      end
    end
  end
end
