require 'cor1440_gen/concerns/models/orgsocial'

module Sip
  class Orgsocial < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Orgsocial
  end
end
