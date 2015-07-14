FactoryGirl.define do
  factory :cor1440_gen_informe, :class => 'Cor1440Gen::Informe' do
    filtrofechaini "2015-07-09"
    filtrofechafin "2015-07-09"
    filtroproyecto nil
    filtroarea nil
    filtropoa nil
    columnanombre false
    columnatipo false
    columnaobjetivo false
    columnaproyecto false
    columnapoblacion false
    recomendaciones "MyString"
    avances "MyString"
    logros "MyString"
    dificultades "MyString"
  end

end
