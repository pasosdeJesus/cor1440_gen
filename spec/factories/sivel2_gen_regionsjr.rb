# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sivel2_gen_regionsjr, class: 'Sivel2Gen::Regionsjr' do
    id 1000
    nombre "Oficina1"
    fechacreacion "2014-08-05"
    fechadeshabilitacion nil
  end
end
