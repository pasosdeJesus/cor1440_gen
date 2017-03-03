# encoding: utf-8

require_relative '../../test_helper'

module Cor1440Gen
  class Cor1440GenFinanciadorTest < ActiveSupport::TestCase
  
    PRUEBA_FINANCIADOR={
      id: 1000 ,
      nombre: "Cor1440_gen_financiador",
      fechacreacion: "2015-04-20",
      created_at: "2015-04-20"
    } 

    test "valido" do
      f = Financiador.create PRUEBA_FINANCIADOR
      assert f.valid?
      f.destroy
    end

    test "no valido" do
      f = Financiador.new PRUEBA_FINANCIADOR
      f.nombre=''
      assert_not f.valid?
      f.destroy
    end

  end
end
