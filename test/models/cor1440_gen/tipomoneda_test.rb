# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class Cor1440GenTipomonedaTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      f = Tipomoneda.create(PRUEBA_TIPOMONEDA)

      assert_predicate f, :valid?
      f.destroy
    end

    test "no valido" do
      f = Tipomoneda.new(PRUEBA_TIPOMONEDA)
      f.nombre = ""

      assert_not f.valid?
      f.destroy
    end
  end
end
