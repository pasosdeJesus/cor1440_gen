require 'test_helper'

module Cor1440Gen
  class ActividadareasActividadTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      aa = Cor1440Gen::Actividadarea.create PRUEBA_ACTIVIDADAREA
      assert aa.valid?
      a = Cor1440Gen::Actividad.create PRUEBA_ACTIVIDAD
      assert a.valid?

      r = Cor1440Gen::ActividadareasActividad.create(
        actividad_id: a.id,
        actividadarea_id: aa.id
      )
      assert r.valid?

      #r.destroy  # Sin llave primaria no destruye, pero se destruye con a
      a.destroy
      aa.destroy
    end

    test "no valido" do
      r = Cor1440Gen::ActividadareasActividad.create()
      assert_not r.valid?
    end

  end
end
