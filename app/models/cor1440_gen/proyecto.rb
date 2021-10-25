require 'cor1440_gen/concerns/models/proyecto'

module Cor1440Gen
  class Proyecto < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Proyecto
  end
end
