# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Financiador
        extend ActiveSupport::Concern
        include Sip::Basica

        included do

          has_many :financiador_proyectofinanciero, dependent: :delete_all,
            class_name: 'Cor1440Gen::FinanciadorProyectofinanciero', 
            foreign_key: 'financiador_id'
          has_many :proyectofinanciero, through: :financiador_proyectofinanciero,
            class_name: 'Cor1440Gen::Proyectofinanciero'

          validates :nombre, presence: true, allow_blank: false, 
            length: { maximum: 1000 } 

        end
      end
    end
  end
end


