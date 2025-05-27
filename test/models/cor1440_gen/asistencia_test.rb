# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class AsistenciaTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      actividad = Actividad.create(PRUEBA_ACTIVIDAD)

      assert_predicate actividad, :valid?
      assert_empty(actividad.rangoedadac_ids)

      persona = Msip::Persona.create(PRUEBA_PERSONA)

      assert persona.valid?

      asistencia = Asistencia.create(PRUEBA_ASISTENCIA.merge(
        actividad_id: actividad.id,
        persona_id: persona.id,
      ))

      assert_predicate asistencia, :valid?
      assert_equal([4], asistencia.actividad.rangoedadac_ids)

      asistencia.destroy
      persona.destroy
      actividad.destroy
    end

    test "no valido" do
      skip
      asistencia = Cor1440Gen::Asistencia.new(PRUEBA_ASISTENCIA.merge(
        persona_id: nil,
      ))

      assert_not asistencia.valid?
      asistencia.destroy
    end
  end
end
