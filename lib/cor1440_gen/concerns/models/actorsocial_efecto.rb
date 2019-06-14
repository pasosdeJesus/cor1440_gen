# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module ActorsocialEfecto
        extend ActiveSupport::Concern

        included do

          belongs_to :actorsocial, class_name: 'Sip::Actorsocial',
            foreign_key: 'actorsocial_id'
          belongs_to :efecto, class_name: 'Cor1440Gen::Efecto',
            foreign_key: 'efecto_id'
        end

      end
    end
  end
end

