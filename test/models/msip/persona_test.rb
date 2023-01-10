# frozen_string_literal: true

require_relative "../../test_helper"

module Msip
  class PersonaTest < ActiveSupport::TestCase
    test "valido" do
      persona = Persona.create(PRUEBA_PERSONA)

      assert_predicate persona, :valid?
      persona.destroy
    end

    test "no valido" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.nombres = ""

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por documento errado" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.tdocumento_id = 1 # cedula
      persona.numerodocumento = "a"

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por año errado" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.anionac = 1

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por año errado 2" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.anionac = 1 + Time.now.strftime("%Y").to_i

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por mes errado" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.mesnac = 0

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por mes errado 2" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.mesnac = 13

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por dia errado" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.dianac = 0

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por dia errado 2" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.dianac = 32

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por dia errado 3" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.mesnac = 4
      persona.dianac = 31

      assert_not persona.valid?
      persona.destroy
    end

    test "no valido por dia errado 4" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.mesnac = 2
      persona.dianac = 30

      assert_not persona.valid?
      persona.destroy
    end

    test "valido con documento no numérico" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.tdocumento_id = 6
      persona.numerodocumento = "T-100"

      assert_predicate persona, :valid?
      persona.destroy
    end

    test "valido sin documento" do
      persona = Persona.new(PRUEBA_PERSONA)
      persona.tdocumento_id = nil
      persona.numerodocumento = nil

      assert_predicate persona, :valid?
      persona.destroy
    end
  end
end
