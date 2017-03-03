# encoding: UTF-8

require_relative '../../test_helper'

module Cor1440Gen
  class ActividadareaTest < ActiveSupport::TestCase

    test "valido" do
      a = Actividadarea.new
		  a.id=1000 # Buscamos que no intefiera con existentes
      a.nombre="Actividadarea"
      a.fechacreacion="2014-09-09"
      a. created_at="2014-09-09"
      assert a.valid?
      a.destroy
    end

    test "no valido" do
      a = Actividadarea.new
		  a.id=1000 # Buscamos que no intefiera con existentes
      a.fechacreacion="2014-09-09"
      a. created_at="2014-09-09"
      assert_not a.valid?
      a.destroy
    end

    test "existente" do
      a = Cor1440Gen::Actividadarea.where(id: 9).take
      assert_equal 'VOLUNTARIADO', a.nombre
    end
  end
end
