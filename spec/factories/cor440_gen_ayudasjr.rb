# encoding: UTF-8

FactoryGirl.define do
  factory :cor440_gen_ayudasjr, class: 'Cor440Gen::Ayudasjr' do
		id 1000 # Buscamos que no intefiera con existentes
    nombre "Ayudasjr"
    fechacreacion "2014-09-11"
    created_at "2014-09-11"
  end
end
