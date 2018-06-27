# encoding: UTF-8

require 'cor1440_gen/concerns/models/sectoractor'

module Cor1440Gen
  class Sectoractor < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Sectoractor
  end
end
