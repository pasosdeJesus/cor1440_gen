# encoding: UTF-8

require_relative '../../test_helper'

module Cor1440Gen
  class RangoedadactTest < ActiveSupport::TestCase

    PRUEBA_RANGOEDADAC = {
      id: 1000,
      nombre: "Rangoedadac",
      fechacreacion: "2014-09-09",
      created_at: "2014-09-09"
    }

    test "valido" do
      re = Rangoedadac.create PRUEBA_RANGOEDADAC
      assert re.valid?
      re.destroy
    end

    test "no valido" do
      re = Rangoedadac.new PRUEBA_RANGOEDADAC
      re.nombre=""
      assert_not re.valid?
      re.destroy
    end

    test "existente" do
      re = Cor1440Gen::Rangoedadac.where(id: 6).take
      assert_equal 'De 61 en adelante', re.nombre
    end

  end
end
