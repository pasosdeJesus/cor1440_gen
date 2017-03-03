# encoding: UTF-8

require_relative '../../test_helper'

module Cor1440Gen
  class ProyectoTest < ActiveSupport::TestCase

    test "valido" do
      p = Proyecto.new
		  p.id=1000 # Buscamos que no interfiera con existentes
      p.nombre="Proyecto"
      p.fechacreacion="2015-04-20"
      p.created_at="2015-04-20"
      assert p.valid?
      p.destroy
    end

    test "no valido" do
      p = Proyecto.new
		  p.id=1000 # Buscamos que no interfiera con existentes
      p.nombre=""
      p.fechacreacion="2015-04-20"
      p.created_at="2015-04-20"
      assert_not p.valid?
      p.destroy
    end

  end
end
