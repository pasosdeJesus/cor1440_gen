require 'cor1440_gen/concerns/models/efecto'

module Cor1440Gen
  class Efecto < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Efecto
  end
end
