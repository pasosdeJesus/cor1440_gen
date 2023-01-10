# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class BeneficiariopfTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      persona = Msip::Persona.create(PRUEBA_PERSONA)
      persona.valid?

      proyectofinanciero = Cor1440Gen::Proyectofinanciero.create(
        PRUEBA_PROYECTOFINANCIERO,
      )

      assert_predicate proyectofinanciero, :valid?

      bpf = Cor1440Gen::Beneficiariopf.create(
        proyectofinanciero_id: proyectofinanciero.id,
        persona_id: persona.id,
      )

      assert_predicate bpf, :valid?

      proyectofinanciero.destroy
      persona.destroy
    end

    test "no valido" do
      i = Cor1440Gen::Beneficiariopf.create

      assert_not i.valid?
    end
  end
end
