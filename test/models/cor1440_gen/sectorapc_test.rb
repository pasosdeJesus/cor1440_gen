# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class Cor1440GenSectorapcTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      sectorapc = Sectorapc.create(PRUEBA_SECTORAPC)

      assert_predicate sectorapc, :valid?
      sectorapc.destroy
    end

    test "no valido" do
      sectorapc = Sectorapc.new(PRUEBA_SECTORAPC)
      sectorapc.nombre = ""

      assert_not sectorapc.valid?
    end

    test "existente" do
      sectorapc = Cor1440Gen::Sectorapc.find_by(id: 1)

      assert_equal "SIN INFORMACIÓN", sectorapc.nombre
    end
  end
end
