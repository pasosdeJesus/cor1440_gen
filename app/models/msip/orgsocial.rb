require 'cor1440_gen/concerns/models/orgsocial'

module Msip
  class Orgsocial < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Orgsocial
  end
end
