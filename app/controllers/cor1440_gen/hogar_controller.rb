# frozen_string_literal: true

module Cor1440Gen
  class HogarController < Msip::HogarController
    # Sin autorización porque es para no autenticados

    def index
      if current_usuario
        authorize!(:nuevo, Cor1440Gen::Actividad)
      end
      render(layout: "application")
    end
  end
end
