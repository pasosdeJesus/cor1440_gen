# encoding: UTF-8

FactoryGirl.define do
  factory :cor1440_gen_proyectofinanciero, class: 'Cor1440Gen::Proyectofinanciero' do
		id 1000 # Buscamos que no interfiera con existentes
    nombre "Proyectofinanciero"
    fechacreacion "2015-04-20"
    created_at "2015-04-20"
  end
end
