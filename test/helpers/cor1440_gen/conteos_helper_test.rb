# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class ConteosHelperTest < ActionView::TestCase
    include ConteosHelper


    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    # Si hace falta instalamos calculo de poblacion automatico con PostgreSQL
    # Probamos agregar, modificar, eliminar asistentes en una actividad
    # Así como:
    # * Modificar la fecha de la actividad --que implica cambio en 
    #   rangos de edad de todos los asistentes.
    # * Modificar fecha de nacimiento de una persona --que implica calculo
    #   de rangos edad en todas las actividades donde esté.
    test "calculo de poblacion en PostgreSQL" do
      if !Msip::SqlHelper.existe_función_pg?('cor1440_gen_actividad_cambiada')
        instala_calculo_poblacion_pg
      end
      persona = Msip::Persona.create!(PRUEBA_PERSONA.merge(
        anionac: 2000,
        mesnac: 1,
        dianac: 1
      ))

      assert persona.valid?

      actividad = Actividad.create!(PRUEBA_ACTIVIDAD.merge(
        fecha: '2023-01-13',
        oficina_id: 1
      ))

      assert actividad.valid?
      # Por extraño motivo actividad.fecha aquí en
      # ocasiones es '2017-03-02'
      actividad.fecha = '2023-01-13'
      actividad.save!
      assert actividad.valid?
      assert_equal actividad.fecha.to_s, '2023-01-13'

      assert_equal 0, ActividadRangoedadac.where(
        actividad_id: actividad.id).count

      asistencia = Asistencia.create(PRUEBA_ASISTENCIA.merge(
        actividad_id: actividad.id,
        persona_id: persona.id,
      ))

      assert_predicate asistencia, :valid?
      if asistencia.actividad.rangoedadac_ids == [2]
        debugger
      end
      assert_equal([3], asistencia.actividad.rangoedadac_ids)

      actividad.fecha = '2063-01-13'
      actividad.save

      actividad.reload
      asistencia.reload
      assert_predicate asistencia, :valid?
      assert_equal([6], actividad.rangoedadac_ids)


      actividad.fecha = '2033-01-13'
      actividad.save

      actividad.reload
      asistencia.reload
      assert_predicate asistencia, :valid?
      assert_equal([4], actividad.rangoedadac_ids)

      persona.anionac = 2023;
      persona.save

      actividad.reload
      asistencia.reload
      assert_predicate asistencia, :valid?
      assert_equal([1], actividad.rangoedadac_ids)

      asistencia.destroy
      actividad.reload
      assert_equal([], actividad.rangoedadac_ids)

   end
  end  # class
end    # module
