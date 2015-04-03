# encoding: UTF-8

require 'cor440_gen/concerns/models/persona'

class Sip::Persona < ActiveRecord::Base
  include Cor440Gen::Concerns::Models::Persona
end

