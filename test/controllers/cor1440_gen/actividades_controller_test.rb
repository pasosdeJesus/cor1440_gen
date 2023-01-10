require 'test_helper'

module Cor1440Gen
  class ActividadesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include Devise::Test::IntegrationHelpers
    
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
      @actividad = Actividad.create(PRUEBA_ACTIVIDAD)
      @current_usuario = ::Usuario.create(PRUEBA_USUARIO) 
      sign_in @current_usuario
    end

    test "should get index" do
      get actividades_url
      assert_response :success
    end

    test "should get new" do
      get new_actividad_url
      assert_response 302
    end

    test "should create actividad" do
      a = PRUEBA_ACTIVIDAD
      a[:fecha_localizada] = a[:fecha]
      assert_difference('Cor1440Gen::Actividad.count') do
        post actividades_url, params: { 
          actividad: PRUEBA_ACTIVIDAD
        }
      end

      assert_redirected_to actividad_url(Cor1440Gen::Actividad.last)
    end

    test "should show actividad" do
      get actividad_url(@actividad)
      assert_response :success
    end

    test "should get edit" do
      get edit_actividad_url(@actividad)
      assert_response :success
    end

    test "should update actividad" do
      patch actividad_url(@actividad), params: { 
        actividad: {  
          nombre: 'otro'
        } 
      }
      assert_redirected_to actividad_url(@actividad)
    end

    test "debería ubicar plantilla para exportar actividad" do
      nombres_plantilla = ['Reporte_actividad.odt', 'reporte_una_actividad.ods',
        'listado_de_actividades.ods']
      nombres_plantilla.each do |np| 
        get ENV.fetch('RUTA_RELATIVA', '/cor1440/') +'sis/arch/plantillas?descarga=' + np
        assert_response :success
      end
    end

    test "deberia exportar una actividad a hoja de calculo" do
      get actividad_path(@actividad) + '/fichaimp.xlsx?genera[plantilla_id]=5.ods&idplantilla=5&formato=ods&formatosalida=xlsx&commit=Enviar'
      assert_response :success
      FileUtils.rm('/tmp/reporte_una_actividad.ods')
      FileUtils.rm('/tmp/reporte_una_actividad.xlsx')
    end

    test "deberia exportar un listado  a hoja de calculo" do
      get actividades_path + '.xlsx?filtro[disgenera]=5&idplantilla=5&formato=xlsx&formatosalida=xlsx&commit=Enviar'
      assert_redirected_to ENV.fetch('RUTA_RELATIVA', '/cor1440/') + 'sis/arch/generados'
    end

    test "should destroy actividad" do
      assert_difference('Cor1440Gen::Actividad.count', -1) do
        delete actividad_url(@actividad)
      end

      assert_redirected_to actividades_url
    end

#    test "enrutamiento" do
#      assert_routing "/actividades", controller: "cor1440_gen/actividades", 
#        action: "index"
#    end
    

  end
end
