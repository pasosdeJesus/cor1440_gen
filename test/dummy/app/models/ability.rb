# frozen_string_literal: true

class Ability < Cor1440Gen::Ability
  # Autorizacion con CanCanCan
  def initialize(usuario = nil)
    initialize_cor1440_gen(usuario)
  end
end
