# encoding: UTF-8
module Cor1440Gen
  class HogarController < Sip::HogarController

    def index
      if current_usuario
        authorize! :contar, Cor1440Gen::Actividad
      end
      render layout: 'application'
    end

  end
end
