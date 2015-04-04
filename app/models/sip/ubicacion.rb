# encoding: UTF-8

require 'cor1440_gen/concerns/models/ubicacion'

class Sip::Ubicacion < ActiveRecord::Base
  include Cor1440Gen::Concerns::Models::Ubicacion
end

