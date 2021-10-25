require 'cor1440_gen/concerns/models/informe'

module Cor1440Gen
  class Informe < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Informe
  end
end
