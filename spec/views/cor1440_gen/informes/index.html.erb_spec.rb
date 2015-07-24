require 'rails_helper'

RSpec.describe "cor1440_gen/informes/index" do
  before(:each) do
    assign(:informes, [
      Cor1440Gen::Informe.create!(
        :titulo=> "titulo",
        :filtrofechaini => "2015-01-01",
        :filtrofechafin => "2015-01-02",
        :filtroproyecto => nil,
        :filtroactividadarea => 9,
        :columnanombre => false,
        :columnatipo => false,
        :columnaobjetivo => false,
        :columnaproyecto => false,
        :columnapoblacion => false,
        :recomendaciones => "Recomendaciones",
        :avances => "Avances",
        :logros => "Logros",
        :dificultades => "Dificultades"
      ),
      Cor1440Gen::Informe.create!(
        :titulo=> "titulo",
        :filtrofechaini => "2015-01-01",
        :filtrofechafin => "2015-01-02",
        :filtroproyecto => nil,
        :filtroactividadarea => 9,
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
    ])
  end

  it "renders a list of informes" do
    view.stub(:will_paginate)
    render
    assert_select "tr>td", :text => "Recomendaciones".to_s, :count => 2
  end
end
