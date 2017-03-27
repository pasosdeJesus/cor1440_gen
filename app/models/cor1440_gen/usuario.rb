# encoding: UTF-8

require 'cor1440_gen/concerns/models/usuario.rb'

module Cor1440Gen
  class Usuario < Sip::Usuario

    include Cor1440Gen::Concerns::Models::Usuario

  end
end
