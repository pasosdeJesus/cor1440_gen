require 'test_helper'

module Cor1440Gen
  class ActividadProyectofinancieroTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      pf = Proyectofinanciero.create PRUEBA_PROYECTOFINANCIERO
      assert pf.valid?
      a = Cor1440Gen::Actividad.create PRUEBA_ACTIVIDAD
      assert a.valid?

      apf = Cor1440Gen::ActividadProyectofinanciero.create(
        actividad_id: a.id,
        proyectofinanciero_id: pf.id
      )
      assert apf.valid?

      #apf.destroy  # Sin llave primaria no destruye, pero se destruye con
                     #a.destroy
      a.destroy
      pf.destroy
    end

    test "no valido" do
      apf = Cor1440Gen::ActividadProyectofinanciero.create()
      assert_not apf.valid?
    end

  end
end
