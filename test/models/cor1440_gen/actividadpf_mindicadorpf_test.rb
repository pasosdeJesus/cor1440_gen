# frozen_string_literal: true

require "test_helper"

module Cor1440Gen
  class ActividadpfMindicadorpfTest < ActiveSupport::TestCase
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
      a = Actividadpf.create(PRUEBA_ACTIVIDADPF.merge(
        proyectofinanciero_id: pf.id,
      ))

      assert_predicate a, :valid?
      m = Mindicadorpf.create(PRUEBA_MINDICADORPF.merge(
        proyectofinanciero_id: pf.id,
      ))

      assert_predicate m, :valid?
      am = ActividadpfMindicadorpf.create(
        actividadpf_id: a.id,
        mindicadorpf_id: m.id,
      )
      am.valid?
      m.destroy
      a.destroy
      i.destroy
      r.destroy
      o.destroy
      pf.destroy
    end

    test "no valido" do
      am = ActividadpfMindicadorpf.new(
        actividadpf_id: nil,
        mindicadorpf_id: nil,
      )

      assert_not am.valid?
    end
  end
end
