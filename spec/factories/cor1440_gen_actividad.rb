# encoding: UTF-8

FactoryGirl.define do
  factory :cor1440_gen_actividad, class: 'Cor1440Gen::Actividad' do
    minutos "45"
    nombre "nombreact"
    oficina_id "1"
    fecha "2014-11-11"
    created_at "2014-11-11"
  end
end
