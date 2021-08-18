require 'cor1440_gen/concerns/models/informenarrativo'

module Cor1440Gen
  class Informenarrativo < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Informenarrativo
  end
end
