require 'cor1440_gen/concerns/models/desembolso'

module Cor1440Gen
  class Desembolso < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Desembolso
  end
end
