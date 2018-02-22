# encoding: UTF-8

require 'cor1440_gen/concerns/models/campoact'

module Cor1440Gen
  class Campoact < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::Campoact
  end
end
