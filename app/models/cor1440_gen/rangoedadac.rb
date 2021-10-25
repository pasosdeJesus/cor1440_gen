require 'cor1440_gen/concerns/models/rangoedadac'

module Cor1440Gen
  class Rangoedadac < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Rangoedadac
  end
end
