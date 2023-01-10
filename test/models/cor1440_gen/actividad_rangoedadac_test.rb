require 'test_helper'

module Cor1440Gen
  class ActividadRangoedadacTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      r = Cor1440Gen::Rangoedadac.create PRUEBA_RANGOEDADAC
      assert r.valid?
      a = Cor1440Gen::Actividad.create PRUEBA_ACTIVIDAD
      assert a.valid?

      ar = Cor1440Gen::ActividadRangoedadac.create(
        actividad_id: a.id,
        rangoedadac_id: r.id
      )
      assert ar.valid?

      #ar.destroy  # Sin llave primaria no destruye, pero se destruye con
                     #a.destroy
      a.destroy
      r.destroy
    end

    test "no valido" do
      ar = Cor1440Gen::ActividadRangoedadac.create()
      assert_not ar.valid?
    end

  end
end
