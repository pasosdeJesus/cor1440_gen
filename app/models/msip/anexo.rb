require 'cor1440_gen/concerns/models/anexo'
module Msip
  class Anexo < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Anexo
  end
end
