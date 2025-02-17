# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class ActividadesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include Devise::Test::IntegrationHelpers

    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
      @current_usuario = ::Usuario.create(PRUEBA_USUARIO)
      sign_in @current_usuario
      @actividad = Actividad.create(PRUEBA_ACTIVIDAD)
    end

    test "debe listar" do
      get actividades_url

      assert_response :success
    end

    test "debe presentar formulario para nueva" do
      get new_actividad_url

      assert_response :redirect
    end

    test "debe presentar formulario para nueva con proyecto por omisión" do
      pf = Proyectofinanciero.create(PRUEBA_PROYECTOFINANCIERO.merge(
        poromision: true,
      ))

      assert_predicate pf, :valid?

      assert_equal 0, Cor1440Gen::ActividadProyectofinanciero.count
      get new_actividad_url

      assert_response :redirect
      assert_equal 1, Cor1440Gen::ActividadProyectofinanciero.count
    end

    test "debe crear una actividad" do
      a = PRUEBA_ACTIVIDAD
      a[:fecha_localizada] = a[:fecha]
      assert_difference("Cor1440Gen::Actividad.count") do
        post actividades_url, params: {
          actividad: PRUEBA_ACTIVIDAD,
        }
      end

      assert_redirected_to actividad_url(Cor1440Gen::Actividad.last)
    end

    test "debe presentar resumen de una actividad" do
      get actividad_url(@actividad)

      assert_response :success
    end

    test "debe presentar formulario de edición" do
      get edit_actividad_url(@actividad)

      assert_response :success
    end

    test "debe actualizar actividad" do
      patch actividad_url(@actividad), params: {
        actividad: {
          nombre: "otro",
        },
      }

      assert_redirected_to actividad_url(@actividad)
    end

    test "debería ubicar plantilla para exportar actividad" do
      nombres_plantilla = [
        "Reporte_actividad.odt",
        "reporte_una_actividad.ods",
        "listado_de_actividades.ods",
      ]
      nombres_plantilla.each do |np|
        ruta = "#{ENV.fetch("RUTA_RELATIVA", "/cor1440/")}" \
          "sis/arch/plantillas?descarga=#{np}"
        get ruta

        assert_response :success
      end
    end

    test "deberia exportar una actividad a hoja de calculo" do
      ruta = "#{actividad_path(@actividad)}" \
        "/fichaimp.xlsx?genera[plantilla_id]=5.ods&" \
        "idplantilla=5&formato=ods&formatosalida=xlsx&commit=Enviar"
      get ruta

      assert_response :success
      FileUtils.rm("/tmp/reporte_una_actividad.ods")
      FileUtils.rm("/tmp/reporte_una_actividad.xlsx")
    end

    test "deberia exportar un listado  a hoja de calculo" do
      get "#{actividades_path}.xlsx?" \
        "filtro[disgenera]=5&idplantilla=5&formato=xlsx&" \
        "formatosalida=xlsx&commit=Enviar"

      assert_redirected_to(
        "#{ENV.fetch("RUTA_RELATIVA", "/cor1440/")}sis/arch/generados",
      )
    end

    test "debe eliminar actividad" do
      assert_difference("Cor1440Gen::Actividad.count", -1) do
        delete actividad_url(@actividad)
      end

      assert_redirected_to actividades_url
    end

    test "crea copia de una actividad" do
      n1 = Cor1440Gen::Actividad.count
      get copiar_actividad_path(@actividad.id)

      assert_response :success
      assert (n1 + 1), Cor1440Gen::Actividad.count
    end

    test "procesa actividad compleja y reporta" do
      pf = Proyectofinanciero.create(PRUEBA_PROYECTOFINANCIERO.merge(
        poromision: true,
      ))

      assert_predicate pf, :valid?

      @actividad.proyectofinanciero_ids = [pf.id]
      @actividad.save

      assert_predicate @actividad, :valid?

      f = ::Mr519Gen::Formulario.create(PRUEBA_FORMULARIO)

      assert_predicate f, :valid?
      r = ::Mr519Gen::Respuestafor.create(PRUEBA_RESPUESTAFOR.merge(
        formulario_id: f.id,
      ))

      assert_predicate r, :valid?

      @actividad.respuestafor_ids = [r.id]
      @actividad.save

      assert_predicate @actividad, :valid?

      get edit_actividad_url(@actividad)

      assert_response :success

      post cor1440_gen.crear_asistencia_path(0, format: :turbo_stream)

      assert_response :success
      # assert_equal (np+1), Msip::Persona.count

      get contar_actividades_beneficiarios_path

      assert_response :success

      get contar_actividades_path

      assert_response :success

      skip # Arreglar con https://github.com/pasosdeJesus/cor1440_gen/issues/118
      assert_difference("Cor1440Gen::Actividad.count", -1) do
        delete actividad_url(@actividad)
      end

      assert_redirected_to actividades_url
    end
  end
end
