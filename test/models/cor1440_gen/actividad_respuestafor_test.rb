# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class ActividadRespuestaforTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      f = ::Mr519Gen::Formulario.create(PRUEBA_FORMULARIO)

      assert_predicate f, :valid?
      r = ::Mr519Gen::Respuestafor.create(PRUEBA_RESPUESTAFOR.merge(
        formulario_id: f.id,
      ))

      assert_predicate r, :valid?
      a = Cor1440Gen::Actividad.create(PRUEBA_ACTIVIDAD)

      assert_predicate a, :valid?

      ar = Cor1440Gen::ActividadRespuestafor.create(
        actividad_id: a.id,
        respuestafor_id: r.id,
      )

      assert_predicate ar, :valid?

      a.destroy
      r.destroy
      f.destroy
    end

    test "no valido" do
      aapf = Cor1440Gen::ActividadRespuestafor.create

      assert_not aapf.valid?
    end
  end
end
