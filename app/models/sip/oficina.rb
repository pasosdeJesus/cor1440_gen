# encoding: UTF-8

require 'cor1440_gen/concerns/models/oficina'

class Sip::Oficina < ActiveRecord::Base
  include Cor1440Gen::Concerns::Models::Oficina
end

