# encoding: UTF-8

require 'cor1440_gen/concerns/models/caracterizacionpf'

module Cor1440Gen
  class Caracterizacionpf < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::Caracterizacionpf
  end
end
