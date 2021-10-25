require 'cor1440_gen/concerns/models/persona'
module Sip
  class Persona < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Persona
  end
end
