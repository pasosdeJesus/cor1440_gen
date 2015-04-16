# encoding: UTF-8

FactoryGirl.define do
  factory :cor1440_gen_actividadarea, :class => 'Cor1440Gen::Actividadarea' do
		id 1000 # Buscamos que no intefiera con existentes
    nombre "Actividadarea"
    fechacreacion "2014-09-09"
    created_at "2014-09-09"
  end
end
