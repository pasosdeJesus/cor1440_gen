require 'test_helper'

module Cor1440Gen
  class ActividadpfTest < ActiveSupport::TestCase
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
      a = Actividadpf.create PRUEBA_ACTIVIDADPF
      assert a.valid?
      a.destroy
      r.destroy
      o.destroy
      pf.destroy
    end

    test "no valido" do
      a = Cor1440Gen::Actividadpf.new PRUEBA_ACTIVIDADPF.merge(
        resultadopf_id: nil
      )
      assert_not a.valid?
      a.destroy
    end

  end
end
