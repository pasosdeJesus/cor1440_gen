# encoding: UTF-8

require 'sip/concerns/models/oficina'

module Cor440Gen
  module Concerns
    module Models
      module Oficina
        extend ActiveSupport::Concern

        included do
#          has_many :casosjr, class_name: 'Cor440Gen::Casosjr',
#            foreign_key: "id_regionsjr", validate: true
        end

        module ClassMethods
        end

      end
    end
  end
end
