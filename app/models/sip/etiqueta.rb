# encoding: UTF-8

require 'cor440_gen/concerns/models/etiqueta'

class Sip::Etiqueta < ActiveRecord::Base
  include Cor440Gen::Concerns::Models::Etiqueta
end

