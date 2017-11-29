# encoding: UTF-8

require 'cor1440_gen/concerns/models/indicadorpf'

module Cor1440Gen
  class Indicadorpf < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Indicadorpf
  end
end
