# enconding: UTF-8

require 'test_helper'

module Cor1440Gen
  class SectoresactoresControllerTest < ActionController::TestCase
    include Engine.routes.url_helpers
    include Devise::Test::IntegrationHelpers

    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
      #@sectoractor = Sectoractor(:one)
      #@proyectofinanciero = Proyectofinanciero.create(
      #  Cor1440Gen::ProyectofinancieroTest::PRUEBA_PROYECTOFINANCIERO
      #)
      #@current_usuario = ::Usuario.create(PRUEBA_USUARIO) 
      #sign_in @current_usuario
    end

    test "should get index" do
      skip
      get sectoresactores_url
      assert_response :success
      assert_not_nil assigns(:sectoractor)
    end

    test "should get new" do
      skip
      get :new
      assert_response :success
    end

    test "should create sectoractor" do
      skip
      assert_difference('Sectoractor.count') do
        post :create, sectoractor: { created_at: @sectoractor.created_at, fechacreacion: @sectoractor.fechacreacion, fechadeshabilitacion: @sectoractor.fechadeshabilitacion, nombre: @sectoractor.nombre, observaciones: @sectoractor.observaciones, updated_at: @sectoractor.updated_at }
      end

      assert_redirected_to sectoractor_path(assigns(:sectoractor))
    end

    test "should show sectoractor" do
      skip
      get :show, id: @sectoractor
      assert_response :success
    end

    test "should get edit" do
      skip
      get :edit, id: @sectoractor
      assert_response :success
    end

    test "should update sectoractor" do
      skip
      patch :update, id: @sectoractor, sectoractor: { created_at: @sectoractor.created_at, fechacreacion: @sectoractor.fechacreacion, fechadeshabilitacion: @sectoractor.fechadeshabilitacion, nombre: @sectoractor.nombre, observaciones: @sectoractor.observaciones, updated_at: @sectoractor.updated_at }
      assert_redirected_to sectoractor_path(assigns(:sectoractor))
    end

    test "should destroy sectoractor" do
      skip
      assert_difference('Sectoractor.count', -1) do
        delete :destroy, id: @sectoractor
      end

      assert_redirected_to sectoractores_path
    end
  end
end
