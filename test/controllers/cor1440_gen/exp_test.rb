# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class ExpTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include Devise::Test::IntegrationHelpers

    setup do
      Rails.application.try(:reload_routes_unless_loaded)
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
      @current_usuario = ::Usuario.create(PRUEBA_USUARIO)
      sign_in @current_usuario
      @actividad = Actividad.create(PRUEBA_ACTIVIDAD)
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
  end
end
