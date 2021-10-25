module Cor1440Gen
  module Concerns
    module Models
      module Validarpf
        extend ActiveSupport::Concern

        included do
          include ActiveModel::Model
          include Sip::Localizacion

          attr_accessor :fechaini
          attr_accessor :fechafin
          campofecha_localizado :fechaini
          campofecha_localizado :fechafin

          def read_attribute(a)
            case a
            when :fechaini
              return @fechaini
            when :fechafin
              return @fechafin
            end
            puts a
            return nil
          end

          def write_attribute(a, v)
            case a
            when :fechaini
              @fechaini = v
              return v
            when :fechafin
              @fechafin = v
              return v
            end
            puts a, v
            return nil
          end


        end

      end
    end
  end
end
