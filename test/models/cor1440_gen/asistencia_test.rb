require 'test_helper'

module Cor1440Gen
  class AsistenciaTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      actividad = Actividad.create PRUEBA_ACTIVIDAD
      assert actividad.valid?
      assert actividad.rangoedadac_ids == []

      persona = Msip::Persona.create PRUEBA_PERSONA
      persona.valid?

      asistencia =  Asistencia.create PRUEBA_ASISTENCIA.merge(
        actividad_id: actividad.id,
        persona_id: persona.id
      )
      assert asistencia.valid?
      assert asistencia.actividad.rangoedadac_ids == [4]

      asistencia.destroy
      persona.destroy
      actividad.destroy
    end

    test "no valido" do
      skip
      asistencia = Cor1440Gen::Asistencia.new(PRUEBA_ASISTENCIA.merge(
        persona_id: nil
      ))
      assert_not asistencia.valid?
      asistencia.destroy
    end

  end
end
