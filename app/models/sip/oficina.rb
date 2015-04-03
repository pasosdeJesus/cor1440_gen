# encoding: UTF-8

require 'cor440_gen/concerns/models/oficina'

class Sip::Oficina < ActiveRecord::Base
  include Cor440Gen::Concerns::Models::Oficina
end

