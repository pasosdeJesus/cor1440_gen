# encoding: UTF-8

FactoryGirl.define do
  factory :cor440_gen_regimensalud, class: 'Cor440Gen::Regimensalud' do
		id 1000 # Buscamos que no intefiera con existentes
    nombre "Regimensalud"
    fechacreacion "2014-12-02"
    created_at "2014-12-02"
  end
end
