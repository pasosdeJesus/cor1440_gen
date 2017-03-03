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
      recomendaciones: 'Recomendaciones',
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

    def verifica_formulario
        assert_select "input#informe_filtrofechaini_localizada[name=?]", "informe[filtrofechaini_localizada]"
        assert_select "input#informe_filtrofechafin_localizada[name=?]", "informe[filtrofechafin_localizada]"

        assert_select "#informe_filtroproyecto[name=?]", "informe[filtroproyecto]"

        assert_select "#informe_filtroactividadarea[name=?]", "informe[filtroactividadarea]"

        assert_select "input#informe_columnanombre[name=?]", "informe[columnanombre]"

        assert_select "input#informe_columnatipo[name=?]", "informe[columnatipo]"

        assert_select "input#informe_columnaobjetivo[name=?]", "informe[columnaobjetivo]"

        assert_select "input#informe_columnaproyecto[name=?]", "informe[columnaproyecto]"

        assert_select "input#informe_columnapoblacion[name=?]", "informe[columnapoblacion]"

        assert_select "#informe_recomendaciones[name=?]", "informe[recomendaciones]"

        assert_select "#informe_avances[name=?]", "informe[avances]"

        assert_select "#informe_logros[name=?]", "informe[logros]"

        assert_select "#informe_dificultades[name=?]", "informe[dificultades]"

    end

    test "should get new" do
      get new_informe_url
      assert_response :success
      assert_select "form"  do
        verifica_formulario
      end
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
      #puts @response.body
      assert_select "h2", :text => "Recomendaciones".to_s
      assert_select "pre", :text => "Recomendaciones".to_s
    end

    test "should get edit" do
      get edit_informe_url(@informe)
      assert_response :success
      #puts @response.body
      assert_select "form[action=?][method=?]", cor1440_gen.informe_path(@informe), "post" do
        verifica_formulario
      end
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
