# encoding: utf-8

require_relative '../../test_helper'
require_relative '../../models/cor1440_gen/proyectofinanciero_test.rb'

module Cor1440Gen
  class ProyectosfinancierosControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include Devise::Test::IntegrationHelpers

    setup do
      @proyectofinanciero = Proyectofinanciero.create(
        Cor1440Gen::ProyectofinancieroTest::PRUEBA_PROYECTOFINANCIERO
      )
      @current_usuario = ::Usuario.create(PRUEBA_USUARIO) 
      sign_in @current_usuario
    end

    test "should get index" do
      get proyectosfinancieros_url
      assert_response :success
    end

    test "should get new" do
      get new_proyectofinanciero_url
      assert_response :success
    end

    test "should create proyectofinanciero" do
      assert_difference('Cor1440Gen::Proyectofinanciero.count') do
        post proyectosfinancieros_url, params: { 
          proyectofinanciero: 
          Cor1440Gen::ProyectofinancieroTest::PRUEBA_PROYECTOFINANCIERO
        }
      end

      assert_redirected_to proyectofinanciero_url(Proyectofinanciero.last)
    end

    test "should show proyectofinanciero" do
      get proyectofinanciero_url(@proyectofinanciero)
      assert_response :success
    end

    test "should get edit" do
      get edit_proyectofinanciero_url(@proyectofinanciero)
      assert_response :success
    end

    test "should update proyectofinanciero" do
      patch proyectofinanciero_url(@proyectofinanciero), params: { 
        proyectofinanciero: {  
          nombre: 'otro'
        } 
      }
      assert_redirected_to proyectofinanciero_url(@proyectofinanciero)
    end

    test "should destroy proyectofinanciero" do
      assert_difference('Proyectofinanciero.count', -1) do
        delete proyectofinanciero_url(@proyectofinanciero)
      end

      assert_redirected_to proyectosfinancieros_url
    end
  end
end
