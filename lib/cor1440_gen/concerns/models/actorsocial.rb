# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Actorsocial
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo 
          include Sip::Localizacion
          include Sip::Basica

          self.table_name = 'cor1440_gen_actorsocial'

        end

      end
    end
  end
end
