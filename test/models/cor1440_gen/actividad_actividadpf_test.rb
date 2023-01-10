require 'test_helper'

module Cor1440Gen
  class ActividadActividadpfTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = 'yyyy-mm-dd'
    end

    test "valido" do
      pf = Proyectofinanciero.create PRUEBA_PROYECTOFINANCIERO
      assert pf.valid?
      o = Objetivopf.create PRUEBA_OBJETIVOPF
      assert o.valid?
      r = Resultadopf.create PRUEBA_RESULTADOPF
      assert r.valid?
      apf = Actividadpf.create PRUEBA_ACTIVIDADPF
      assert apf.valid?
      a = Cor1440Gen::Actividad.create PRUEBA_ACTIVIDAD
      assert a.valid?

      aapf = Cor1440Gen::ActividadActividadpf.create(
        actividad_id: a.id,
        actividadpf_id: apf.id
      )
      assert aapf.valid?

      #aapf.destroy  # Sin llave primaria no destruye, pero se destruye con
                     #a.destroy
      a.destroy
      apf.destroy
      r.destroy
      o.destroy
      pf.destroy
    end

    test "no valido" do
      aapf = Cor1440Gen::ActividadActividadpf.create()
      assert_not aapf.valid?
    end

  end
end
