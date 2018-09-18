# encoding: UTF-8

require 'sip/concerns/models/persona'

module Cor1440Gen
  module Concerns
    module Models
      module Persona
        extend ActiveSupport::Concern
        include Sip::Concerns::Models::Persona

        included do

          has_many :asistente, foreign_key: 'persona_id', validate: true,
            class_name: 'Sivel2Gen::Asistente'

        end # included
      end
    end
  end
end

