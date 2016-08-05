require 'rails_helper'

RSpec.describe "cor1440_gen/informes/edit", type: :view do
  before(:each) do
    skip # Rails 5
    @informe = assign(:informe, Cor1440Gen::Informe.create!(
        :titulo=> "titulo",
        :filtrofechaini => "2015-01-01",
        :filtrofechafin => "2015-01-02",
        :filtroproyecto => nil,
        :filtroactividadarea => 9,
        :columnafecha => false,
        :columnaresponsable => false,
        :columnanombre => false,
        :columnatipo => false,
        :columnaobjetivo => false,
        :columnaproyecto => false,
        :columnapoblacion => false,
        :recomendaciones => "Recomendaciones",
        :avances => "Avances",
        :logros => "Logros",
        :dificultades => "Dificultades"
      )
    )
  end

  it "renders the edit informe form" do
    render

    assert_select "form[action=?][method=?]", cor1440_gen.informe_path(@informe), "post" do

      assert_select "input#informe_filtrofechaini[name=?]", "informe[filtrofechaini]"
      assert_select "input#informe_filtrofechafin[name=?]", "informe[filtrofechafin]"

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
  end
end
