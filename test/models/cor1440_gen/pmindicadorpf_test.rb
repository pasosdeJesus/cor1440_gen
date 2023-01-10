require 'test_helper'

module Cor1440Gen
  class PmindicadorpfTest < ActiveSupport::TestCase
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
      mindicadorpf = Mindicadorpf.create PRUEBA_MINDICADORPF
      assert mindicadorpf.valid?

      pmindicadorpf = Pmindicadorpf.create PRUEBA_PMINDICADORPF
      assert pmindicadorpf.valid?
      pmindicadorpf.destroy

      mindicadorpf.destroy
      i.destroy
      r.destroy
      o.destroy
      pf.destroy
    end

    test "no valido" do
      i = Cor1440Gen::Pmindicadorpf.new PRUEBA_PMINDICADORPF.merge(
        mindicadorpf_id: nil
      )
      assert_not i.valid?
      i.destroy
    end

  end
end
