# encoding: UTF-8

FactoryGirl.define do
  factory :cor1440_gen_rangoedadac, class: 'Cor1440Gen::Rangoedadac' do
		id 1000 # Buscamos que no intefiera con existentes
    nombre "Rangoedadac"
    fechacreacion "2014-09-09"
    created_at "2014-09-09"
  end
end
