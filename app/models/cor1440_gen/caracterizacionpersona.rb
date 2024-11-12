# frozen_string_literal: true

require "cor1440_gen/concerns/models/caracterizacionpersona"

module Cor1440Gen
  # Relación n:n entre persona y respuestas a un formulario (de
  # caracterización).
  #
  # Un registro corresponde a las respuestas para un beneficiario a
  # un formulario de caracterización.
  #
  # Junto con cor1440_gen_beneficiariopf y cor1440_gen_caracterizacionpf
  # permite asociar un formulario de caracterización a una beneficiario de un 
  # proyecto financiero para ampliar el formulario del beneficiario y 
  # sistematizar lo especifico que requiera el proyecto para
  # sus beneficiarios.
  #
  # Para que sea posible diligenciar un formulario (de caracterización) como 
  # subformulario al editar un beneficiario b es necesario que:
  # 1. Exista el formulario digamos f
  # 2. El formulario de caracterizacion f aparezca como tal en 
  #    cor1440_gen_caracterizacionpf para un proyecto financiero p
  # 3. El beneficiario aparezca como beneficiario del proyecto p en
  #    cor1440_gen_beneficiariopf
  # 4. Las respuestas al formulario f para el beneficiario b queden en
  #    cor1440_gen_caracterizacionpersona.
  class Caracterizacionpersona < ActiveRecord::Base
    include Cor1440Gen::Concerns::Models::Caracterizacionpersona
  end
end
