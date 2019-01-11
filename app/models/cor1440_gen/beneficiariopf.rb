# encoding: UTF-8

require 'cor1440_gen/concerns/models/beneficiariopf'

module Cor1440Gen
  class Beneficiariopf < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::Beneficiariopf
  end
end
