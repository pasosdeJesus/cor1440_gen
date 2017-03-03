# encoding: UTF-8

require_relative '../../test_helper'

module Cor1440Gen
  class ProyectofinancieroTest < ActiveSupport::TestCase

    test "valido" do
      pf = Proyectofinanciero.new
      pf.id=1000 # Buscamos que no interfiera con existentes
      pf.nombre="Proyectofinanciero"
      pf.fechacreacion="2015-04-20"
      pf.created_at="2015-04-20"
      assert pf.valid?
      pf.destroy
    end

    test "no valido" do
      pf = Proyectofinanciero.new
      pf.id=1000 # Buscamos que no interfiera con existentes
      pf.nombre=""
      pf.fechacreacion="2015-04-20"
      pf.created_at="2015-04-20"
      assert_not pf.valid?
      pf.destroy
    end

  end
end
