require 'cor1440_gen/concerns/models/efecto_orgsocial'

module Cor1440Gen
  class EfectoOrgsocial < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::EfectoOrgsocial
  end
end
