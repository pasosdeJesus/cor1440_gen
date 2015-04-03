# encoding: UTF-8

FactoryGirl.define do
  factory :sivel2_sjr_derecho, class: 'Sivel2Sjr::Derecho' do
		id 1000 # Buscamos que no intefiera con existentes
    nombre "Derecho"
    fechacreacion "2014-09-11"
    created_at "2014-09-11"
  end
end
