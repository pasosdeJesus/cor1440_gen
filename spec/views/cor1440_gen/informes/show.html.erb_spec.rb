require 'rails_helper'

RSpec.describe "cor1440_gen/informes/show", type: :view do
  before(:each) do
    skip #Rails 5
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
    ))
  end

  it "renders attributes in <p>" do
    @enctabla = ['f'] 
    @cuerpotabla = [['f']] 
    render
    expect(rendered).to match(/Recomendaciones/)
  end
end
