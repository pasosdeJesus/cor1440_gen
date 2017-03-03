# encoding: utf-8

require_relative '../../test_helper'

module Cor1440Gen
  class InformesControllerTest < ActionDispatch::IntegrationTest

    include Engine.routes.url_helpers
    include Devise::Test::IntegrationHelpers

    PRUEBA_INFORME={
      titulo: "Informe",
      filtrofechaini: "2014-09-09",
      filtrofechafin: "2014-09-09",
      created_at: "2014-09-09",
      updated_at: "2014-09-09"
    }

    setup do
      @informe = Informe.create(PRUEBA_INFORME)
      @current_usuario = ::Usuario.create(PRUEBA_USUARIO) 
      sign_in @current_usuario
    end

    test "should get index" do
      get cor1440_gen.informes_url
      assert_response :success
    end

    test "should get new" do
      get new_informe_url
      assert_response :success
    end

    test "should create informe" do
      assert_difference('Informe.count') do
        post cor1440_gen.informes_url, params: { 
          informe: PRUEBA_INFORME
        }
      end

      assert_redirected_to informe_url(Cor1440Gen::Informe.last)
    end

    test "should show informe" do
      get informe_url(@informe)
      assert_response :success
    end

    test "should get edit" do
      get edit_informe_url(@informe)
      assert_response :success
    end

    test "should update informe" do
      patch informe_url(@informe), params: { 
        informe: {
          titulo: 'otro'
        } 
      }
      assert_redirected_to informe_url(@informe)
    end

    test "should destroy informe" do
      assert_difference('Cor1440Gen::Informe.count', -1) do
        delete informe_url(@informe)
      end

      assert_redirected_to informes_url
    end

  end
end
