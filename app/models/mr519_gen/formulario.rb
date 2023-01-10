# frozen_string_literal: true

require "cor1440_gen/concerns/models/formulario"
module Mr519Gen
  class Formulario < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Formulario
  end
end
