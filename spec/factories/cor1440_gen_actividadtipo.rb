# encoding: UTF-8

FactoryGirl.define do
  factory :cor1440_gen_actividadtipo, class: 'Cor1440Gen::Actividadtipo' do
		id 1000 # Buscamos que no interfiera con existentes
    nombre "Cor1440_gen_actividadtipo"
    fechacreacion "2015-04-20"
    created_at "2015-04-20"
  end
end
