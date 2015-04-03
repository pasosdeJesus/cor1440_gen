# encoding: UTF-8

FactoryGirl.define do
  factory :sivel2_sjr_statusmigratorio, class: 'Sivel2Sjr::Statusmigratorio' do
		id 1000 # Buscamos que no intefiera con existentes
    nombre "Statusmigratorio"
    fechacreacion "2014-09-11"
    created_at "2014-09-11"
  end
end
