require 'test_helper'

module Cor1440Gen
  class ActividadOrgsocialTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      grupoper = Msip::Grupoper.create(PRUEBA_GRUPOPER)
      assert_predicate grupoper, :valid?
      o = Msip::Orgsocial.create PRUEBA_ORGSOCIAL.merge(
        grupoper_id: grupoper.id
      )
      assert o.valid?
      a = Cor1440Gen::Actividad.create PRUEBA_ACTIVIDAD
      assert a.valid?

      ar = Cor1440Gen::ActividadOrgsocial.create(
        actividad_id: a.id,
        orgsocial_id: o.id
      )
      assert ar.valid?

      #ar.destroy  # Sin llave primaria no destruye, pero se destruye con
                     #a.destroy
      a.destroy
      o.destroy
      grupoper.destroy
    end

    test "no valido" do
      ar = Cor1440Gen::ActividadOrgsocial.create()
      assert_not ar.valid?
    end

  end
end
