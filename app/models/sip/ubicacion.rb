# encoding: UTF-8

require 'cor440_gen/concerns/models/ubicacion'

class Sip::Ubicacion < ActiveRecord::Base
  include Cor440Gen::Concerns::Models::Ubicacion
end

