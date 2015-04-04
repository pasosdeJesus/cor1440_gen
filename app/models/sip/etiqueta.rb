# encoding: UTF-8

require 'cor1440_gen/concerns/models/etiqueta'

class Sip::Etiqueta < ActiveRecord::Base
  include Cor1440Gen::Concerns::Models::Etiqueta
end

