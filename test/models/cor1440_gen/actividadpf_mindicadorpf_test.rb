require 'test_helper'

module Cor1440Gen
  class ActividadpfMindicadorpfTest < ActiveSupport::TestCase
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
      i = Indicadorpf.create PRUEBA_INDICADORPF
      assert i.valid?
      a = Actividadpf.create PRUEBA_ACTIVIDADPF
      assert a.valid?
      m = Mindicadorpf.create PRUEBA_MINDICADORPF
      assert m.valid?
      am = ActividadpfMindicadorpf.create(
        actividadpf_id: a.id,
        mindicadorpf_id: m.id
      )
      am.valid?
      m.destroy
      a.destroy
      i.destroy
      r.destroy
      o.destroy
      pf.destroy
    end

    test "no valido" do
      am = ActividadpfMindicadorpf.new(
        actividadpf_id: nil,
        mindicadorpf_id: nil
      )
      assert_not am.valid?
    end

  end
end
