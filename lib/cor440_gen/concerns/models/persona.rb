# encoding: UTF-8

require 'sip/concerns/models/persona'

module Cor440Gen
  module Concerns
    module Models
      module Persona
        extend ActiveSupport::Concern
        include Sip::Concerns::Models::Persona

        included do
          #belongs_to :nacional, class_name: "Sip::Pais", 
          #  foreign_key: "nacionalde", validate: true
        end

        module ClassMethods
        end

      end
    end
  end
end
