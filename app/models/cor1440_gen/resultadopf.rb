# encoding: UTF-8

require 'cor1440_gen/concerns/models/resultadopf'

module Cor1440Gen
  class Resultadopf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Resultadopf
  end
end
