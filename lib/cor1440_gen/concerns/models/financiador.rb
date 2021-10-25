module Cor1440Gen
  module Concerns
    module Models
      module Financiador
        extend ActiveSupport::Concern
        include Sip::Basica

        included do

          has_and_belongs_to_many :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'financiador_id',
            association_foreign_key: 'proyectofinanciero_id',
            join_table: 'cor1440_gen_financiador_proyectofinanciero'

          validates :nombre, presence: true, allow_blank: false, 
            length: { maximum: 1000 } 

        end
      end
    end
  end
end


