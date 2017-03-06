# encoding: UTF-8

require_relative '../../test_helper'

module Cor1440Gen
  class ProyectofinancieroTest < ActiveSupport::TestCase

    PRUEBA_PROYECTOFINANCIERO = {
      nombre: "Proyectofinanciero",
      fechacreacion: "2015-04-20",
      created_at: "2015-04-20"
    }

    test "valido" do
      pf = Proyectofinanciero.create PRUEBA_PROYECTOFINANCIERO
      assert pf.valid?
      pf.destroy
    end

    test "no valido" do
      pf = Proyectofinanciero.new PRUEBA_PROYECTOFINANCIERO
      pf.nombre=""
      assert_not pf.valid?
      pf.destroy
    end

  end
end
