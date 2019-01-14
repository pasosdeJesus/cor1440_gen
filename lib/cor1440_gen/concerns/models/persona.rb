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
            class_name: 'Cor1440Gen::Proyectofinanciero', 
            foreign_key: 'persona_id',
            association_foreign_key: 'proyectofinanciero_id',
            join_table: 'cor1440_gen_beneficiariopf'

          has_many :caracterizacionpersona,
            class_name: 'Cor1440Gen::Caracterizacionpersona', 
            foreign_key: 'persona_id'
          accepts_nested_attributes_for :caracterizacionpersona,
            reject_if: :all_blank

          def presenta_nombre
            ip = numerodocumento
            if tdocumento
              ip = tdocumento.sigla + ":" + ip
            end
            r = nombres + " " + apellidos + 
              " (" + ip + ")"
            r
          end
        end # included
      end
    end
  end
end



