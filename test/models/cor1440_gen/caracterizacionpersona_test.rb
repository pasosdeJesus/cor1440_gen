# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class CaracterizacionpersonaTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      u = ::Usuario.create(PRUEBA_USUARIO)
      u.valid?
      f = ::Mr519Gen::Formulario.create(PRUEBA_FORMULARIO)

      assert_predicate f, :valid?
      r = ::Mr519Gen::Respuestafor.create(PRUEBA_RESPUESTAFOR.merge(
        formulario_id: f.id,
      ))

      assert_predicate r, :valid?
      p = Msip::Persona.create(PRUEBA_PERSONA)

      assert_predicate p, :valid?

      cp = Cor1440Gen::Caracterizacionpersona.create(
        persona_id: p.id,
        respuestafor_id: r.id,
        ulteditor_id: u.id,
      )

      assert_predicate cp, :valid?

      cp.destroy
      p.destroy
      r.destroy
      f.destroy
      u.destroy
    end

    test "no valido" do
      cp = Cor1440Gen::Caracterizacionpersona.create

      assert_not cp.valid?
    end
  end
end
