# encoding: UTF-8

require 'cor1440_gen/concerns/models/persona'

class Sip::Persona < ActiveRecord::Base
  include Cor1440Gen::Concerns::Models::Persona
end

