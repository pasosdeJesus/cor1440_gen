# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Financiador
        extend ActiveSupport::Concern
        include Sip::Basica

        included do

          has_many :proyectofinanciero, class_name: 'Cor1440Gen::Proyectofinanciero',
            dependent: :delete_all
        end
      end
    end
  end
end


