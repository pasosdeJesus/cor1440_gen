require 'cor1440_gen/concerns/models/actividad_orgsocial'

module Cor1440Gen
  class ActividadOrgsocial < ActiveRecord::Base
        include Cor1440Gen::Concerns::Models::ActividadOrgsocial
  end
end
