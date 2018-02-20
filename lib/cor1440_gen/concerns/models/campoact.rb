# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Campoact
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo 

          belongs_to :actividadtipo, class_name: 'Cor1440Gen::Actividadtipo',
            foreign_key: 'actividadtipo_id'

          has_many :valorcampoact, dependent: :delete_all,
            class_name: 'Cor1440Gen::Valorcampoact',
            foreign_key: 'campoact_id',  validate: true

          validates :nombrecampo, length: { maximum: 128}
          validates :ayudauso, length: { maximum: 1024}

        end # included
      end
    end
  end
end

