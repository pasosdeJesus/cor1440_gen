# encoding: UTF-8

FactoryGirl.define do
  factory :cor440_gen_ayudaestado, class: 'Cor440Gen::Ayudaestado' do
		id 1000 # Buscamos que no intefiera con existentes
    nombre "Ayudaestado"
    fechacreacion "2014-09-11"
    created_at "2014-09-11"
  end
end
