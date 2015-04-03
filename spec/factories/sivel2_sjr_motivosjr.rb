# encoding: UTF-8

FactoryGirl.define do
  factory :sivel2_sjr_motivosjr, class: 'Sivel2Sjr::Motivosjr' do
		id 1000 # Buscamos que no intefiera con existentes
    nombre "Motivosjr"
    fechacreacion "2014-09-11"
    created_at "2014-09-11"
  end
end
