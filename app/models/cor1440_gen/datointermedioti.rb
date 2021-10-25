require 'cor1440_gen/concerns/models/datointermedioti'

module Cor1440Gen
  class Datointermedioti < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Datointermedioti
  end
end
