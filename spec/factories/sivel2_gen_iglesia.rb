# encoding: UTF-8

FactoryGirl.define do
  factory :sivel2_gen_iglesia, class: 'Sivel2Gen::Iglesia' do
		id 1000 # Buscamos que no intefiera con existentes
    nombre "Iglesia"
    fechacreacion "2014-09-11"
    created_at "2014-09-11"
  end
end
