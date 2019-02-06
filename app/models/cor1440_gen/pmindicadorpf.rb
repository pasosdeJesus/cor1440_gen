# encoding: UTF-8

require 'cor1440_gen/concerns/models/pmindicadorpf'

module Cor1440Gen
  class Pmindicadorpf < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::Pmindicadorpf
  end
end
