require 'test_helper'

module Cor1440Gen
  class MindicadorpfTest < ActiveSupport::TestCase
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
      m = Mindicadorpf.create PRUEBA_MINDICADORPF
      assert m.valid?
      m.destroy
      i.destroy
      r.destroy
      o.destroy
      pf.destroy
    end

    test "no valido" do
      i = Cor1440Gen::Mindicadorpf.new PRUEBA_MINDICADORPF.merge(
        indicadorpf_id: nil
      )
      assert_not i.valid?
      i.destroy
    end

  end
end
