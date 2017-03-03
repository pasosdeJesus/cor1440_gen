# encoding: UTF-8

require_relative '../../test_helper'

module Cor1440Gen
  class InformeTest < ActiveSupport::TestCase

    test "valido" do
      i = Informe.new
		  i.id=1000 # Buscamos que no intefiera con existentes
      i.titulo="Informe"
      i.filtrofechaini="2014-09-09"
      i.filtrofechafin="2014-09-09"
      i.created_at="2014-09-09"
      i.updated_at="2014-09-09"
      assert i.valid?
      i.destroy
    end

    test "no valido" do
      i = Informe.new
		  i.id=1000 # Buscamos que no intefiera con existentes
      i.titulo=""
      i.filtrofechaini="2014-09-09"
      i.filtrofechafin="2014-09-09"
      i.created_at="2014-09-09"
      i.updated_at="2014-09-09"
      assert_not i.valid?
      i.destroy
    end

  end
end
