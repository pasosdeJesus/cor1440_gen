require 'rails_helper'

RSpec.describe "cor1440_gen/informes/new", type: :view do
  before(:each) do
    skip # Rails 5
    assign(:informe, Cor1440Gen::Informe.new(
        :titulo=> "titulo",
        :filtrofechaini => "2015-01-01",
        :filtrofechafin => "2015-01-02",
        :filtroproyecto => nil,
        :filtroactividadarea => 1,
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

  it "renders new informe form" do
    render

    assert_select "form[action=?][method=?]", cor1440_gen.informes_path, "post" do

      assert_select "input#informe_filtrofechaini[name=?]", "informe[filtrofechaini]"
      assert_select "select#informe_filtroproyecto"

      assert_select "select#informe_filtroactividadarea"

      assert_select "input#informe_columnanombre[name=?]", "informe[columnanombre]"

      assert_select "input#informe_columnatipo[name=?]", "informe[columnatipo]"

      assert_select "input#informe_columnaobjetivo[name=?]", "informe[columnaobjetivo]"

      assert_select "input#informe_columnaproyecto[name=?]", "informe[columnaproyecto]"

      assert_select "input#informe_columnapoblacion[name=?]", "informe[columnapoblacion]"

      assert_select "textarea#informe_recomendaciones"

      assert_select "textarea#informe_avances"

      assert_select "textarea#informe_logros"

      assert_select "textarea#informe_dificultades"
    end
  end
end
