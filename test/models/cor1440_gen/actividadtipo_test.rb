# encoding: UTF-8

require_relative '../../test_helper'

module Cor1440Gen
  class ActividadtipoTest < ActiveSupport::TestCase

    test "valido" do
      at = Actividadtipo.new
      at.id=1000 # Buscamos que no interfiera con existentes
      at.nombre="Cor1440_gen_actividadtipo"
      at.fechacreacion="2015-04-20"
      at.created_at="2015-04-20"
      assert at.valid?
      at.destroy
    end

    test "no valido" do
      at = Actividadtipo.new
      at.id=1000 # Buscamos que no interfiera con existentes
      at.nombre=''
      at.fechacreacion="2015-04-20"
      at.created_at="2015-04-20"
      assert_not at.valid?
      at.destroy
    end

  end
end
