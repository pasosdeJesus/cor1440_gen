require 'cor1440_gen/concerns/models/caracterizacionpersona'

module Cor1440Gen
  class Caracterizacionpersona < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Caracterizacionpersona
  end
end
