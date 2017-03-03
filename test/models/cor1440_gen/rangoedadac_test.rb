# encoding: UTF-8

require_relative '../../test_helper'

module Cor1440Gen
  class RangoedadactTest < ActiveSupport::TestCase

    test "valido" do
      re = Rangoedadac.new
		  re.id=1000 # Buscamos que no intefiera con existentes
      re.nombre="Rangoedadac"
      re.fechacreacion="2014-09-09"
      re.created_at="2014-09-09"
      assert re.valid?
      re.destroy
    end

    test "no valido" do
      re = Rangoedadac.new
		  re.id=1000 # Buscamos que no intefiera con existentes
      re.nombre=""
      re.fechacreacion="2014-09-09"
      re.created_at="2014-09-09"
      assert_not re.valid?
      re.destroy
    end

    test "existente" do
      re = Cor1440Gen::Rangoedadac.where(id: 6).take
      assert_equal 'De 61 en adelante', re.nombre
    end

  end
end
