# frozen_string_literal: true

require_relative "../../test_helper"
require_relative "../../models/cor1440_gen/proyectofinanciero_test.rb"

module Cor1440Gen
  class ProyectosfinancierosControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    include Devise::Test::IntegrationHelpers

    setup do
      Rails.application.try(:reload_routes_unless_loaded)
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
      @proyectofinanciero = Proyectofinanciero.create(PRUEBA_PROYECTOFINANCIERO)
      @current_usuario = ::Usuario.create(PRUEBA_USUARIO)
      sign_in @current_usuario
    end

    test "debe listar" do
      get proyectosfinancieros_url

      assert_response :success
    end

    test "debe presentar formulario para nuevo" do
      get new_proyectofinanciero_url

      assert_response :found
    end

    test "debe crear proyectofinanciero" do
      p = PRUEBA_PROYECTOFINANCIERO
      p[:id] = nil
      p[:nombre] = "norepetido"
      p[:fechainicio_localizada] = p[:fechainicio]
      p[:fechacierre_localizada] = p[:fechacierre]
      assert_difference("Cor1440Gen::Proyectofinanciero.count") do
        post proyectosfinancieros_url, params: {
          proyectofinanciero: p,
        }
      end

      assert_redirected_to proyectofinanciero_url(Proyectofinanciero.last)
    end

    test "debe presentar resumen de proyectofinanciero" do
      get proyectofinanciero_url(@proyectofinanciero)

      assert_response :success
    end

    test "debe presentar formulario de edición" do
      get edit_proyectofinanciero_url(@proyectofinanciero)

      assert_response :success
    end

    test "debe actualizar proyectofinanciero" do
      patch proyectofinanciero_url(@proyectofinanciero), params: {
        proyectofinanciero: {
          nombre: "otro",
        },
      }

      assert_redirected_to proyectofinanciero_url(@proyectofinanciero)
    end

    test "debe eliminar proyectofinanciero" do
      assert_difference("Proyectofinanciero.count", -1) do
        delete proyectofinanciero_url(@proyectofinanciero)
      end

      assert_redirected_to proyectosfinancieros_url
    end
  end
end
