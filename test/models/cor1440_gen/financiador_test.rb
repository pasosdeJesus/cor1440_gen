# encoding: utf-8

require_relative '../../test_helper'

module Cor1440Gen
  class Cor1440GenFinanciadorTest < ActiveSupport::TestCase

    test "valido" do
      f = Financiador.new
		  f.id=1000 # Buscamos que no interfiera con existentes
      f.nombre="Cor1440_gen_financiador"
      f.fechacreacion="2015-04-20"
      f.created_at="2015-04-20"
      assert f.valid?
      f.destroy
    end

    test "no valido" do
      f = Financiador.new
		  f.id=1000 # Buscamos que no interfiera con existentes
      f.nombre=''
      f.fechacreacion="2015-04-20"
      f.created_at="2015-04-20"
      assert_not f.valid?
      f.destroy
    end

  end
end
