# encoding: UTF-8

require 'sip/concerns/models/persona'

module Cor1440Gen
  module Concerns
    module Models
      module Persona
        extend ActiveSupport::Concern

        included do
          include Sip::Concerns::Models::Persona

          has_and_belongs_to_many :proyectofinanciero, 
            class_name: 'Sip::Proyectofinanciero', 
            foreign_key: 'persona_id',
            association_foreign_key: 'proyectofinanciero_id',
            join_table: 'cor1440_gen_beneficiariopf'

        end # included
      end
    end
  end
end



