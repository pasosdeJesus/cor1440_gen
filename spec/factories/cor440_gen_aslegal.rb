# encoding: UTF-8

FactoryGirl.define do
  factory :cor440_gen_aslegal, class: 'Cor440Gen::Aslegal' do
		id 1000 # Buscamos que no intefiera con existentes
    nombre "Aslegal"
    fechacreacion "2014-09-11"
    created_at "2014-09-11"
  end
end
