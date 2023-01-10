# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class IndicadorpfTest < ActiveSupport::TestCase
    setup do
      Rails.application.config.x.formato_fecha = "yyyy-mm-dd"
    end

    test "valido" do
      pf = Proyectofinanciero.create(PRUEBA_PROYECTOFINANCIERO)

      assert_predicate pf, :valid?
      o = Objetivopf.create(PRUEBA_OBJETIVOPF.merge(
        proyectofinanciero_id: pf.id,
      ))

      assert_predicate o, :valid?
      r = Resultadopf.create(PRUEBA_RESULTADOPF.merge(
        proyectofinanciero_id: pf.id,
      ))

      assert_predicate r, :valid?
      i = Indicadorpf.create(PRUEBA_INDICADORPF.merge(
        proyectofinanciero_id: pf.id,
      ))

      assert_predicate i, :valid?
      i.destroy
      r.destroy
      o.destroy
      pf.destroy
    end

    test "no valido" do
      i = Cor1440Gen::Indicadorpf.new(PRUEBA_INDICADORPF.merge(
        numero: nil,
      ))

      assert_not i.valid?
      i.destroy
    end
  end
end
