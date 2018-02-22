# encoding: UTF-8

require 'cor1440_gen/concerns/models/valorcampoact'

module Cor1440Gen
  class Valorcampoact < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Valorcampoact
  end
end
