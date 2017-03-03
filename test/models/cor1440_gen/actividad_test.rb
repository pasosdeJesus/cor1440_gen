# encoding: UTF-8

require_relative '../../test_helper'

module Cor1440Gen
  class ActividadTest < ActiveSupport::TestCase

    test "valido" do
      a = Cor1440Gen::Actividad.new
      a.nombre='n'
      a.fecha='2017-03-02'
      a.oficina_id=1
      assert a.valid?
      a.destroy
    end

    test "no valido" do
      a = Cor1440Gen::Actividad.new
      a.nombre='n'
      a.fecha='2017-03-02'
      assert_not a.valid?
      a.destroy
    end

  end
end
