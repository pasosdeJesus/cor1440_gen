# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Financiador
        extend ActiveSupport::Concern

        included do
          validates :nombre, presence: true, allow_blank: false
          validates :fechacreacion, presence: true, allow_blank: false
        end
      end
    end
  end
end


