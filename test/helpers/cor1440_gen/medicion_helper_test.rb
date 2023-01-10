# frozen_string_literal: true

require_relative "../../test_helper"
require "cor1440_gen/medicion_helper"

module Cor1440Gen
  class MedicionHelperTest < ActionView::TestCase
    include MedicionHelper

    # Por ahora nos concentramos en números para presentar resultados
    # cuantitativos --aunque podrían requerir filtros que si deban
    # recurrir a cadenas, fechas y otros tipos que por el momento se
    # mantienen en Ruby.
    #
    # Los datos que se manejan son:
    #   1. Número (enteros y flotantes). Se representan en decimal con ,
    #      para separar parte entera de parte decimal --notación de Colombia.
    #   2. Registro de una tabla (o tupla) (por ejemplo una actividad
    #      que tiene propiedades numéricas como población, tipo cadena
    #      como nombre y tipo fecha como fecha).  Referenciado por un
    #      identificador (en singular si es escalar o registro o plural si
    #        es vector).
    #      No tiene sintaxi en lenguaje, pero para ejemplos
    #      podemos representar una actividad con
    #      {fecha: '2021-10-10', id: 433, nombre: 'Taller'}
    #   3. Vector (de un solo tipo, números, cadenas, fechas o registros de
    #      la misma tabla). Referenciado por un identificador. Notación
    #      preferible en plural.
    #      No tienen sintaxis en lenguaje, pero para ejemplos
    #      podemos representar un vector de números con
    #      [1, 3, 4, 5] y de actividades con [{fecha:'2021-10-10', id:2},
    #       {fecha: '2021-11-11', id: 3}]
    #
    # Identificadores (como notación se sugieren tablas y vectores
    #   comenzando en mayúscula y en plural), lo que representa un número,
    #   fecha, cadena o escalar en minúscula y en singular
    # :
    #   1. Dato intermedio ya definido (e.g num_mujeres_lactantes)
    #   2. Campo de un registro (o proyección) (e.g población en el contexto
    #     de una actividad a sería primera(Actividades).población).
    #     También incluye un
    #     formulario incrustado en el registro (e.g anticipo en
    #     primera(Actividades).anticipo)
    #   3. Una tabla (e.g Actividades, Organizaciones, personas, proyectos)
    #   4. Otros definidos en ruby, por lo menos:
    #     * actividades_contribuyentes Actividades que aportan a un indicador de
    #       resultado
    #     * efectos_contribuyentes Actividades que aportan a un indicador de
    #       efecto
    test "números e identificadores" do
      # números
      assert revisa_sintaxis_expresion(" 1 ")
      assert revisa_sintaxis_expresion("\n1,0\t")
      assert revisa_sintaxis_expresion("-2")
      assert revisa_sintaxis_expresion("-2,0")
      assert_not revisa_sintaxis_expresion("1,")
      assert_not revisa_sintaxis_expresion(",1")
      assert_not revisa_sintaxis_expresion("1, 0")
      # identificadores
      assert revisa_sintaxis_expresion("m")
      assert revisa_sintaxis_expresion("_m")
      assert revisa_sintaxis_expresion("_m0")
      assert revisa_sintaxis_expresion("_0")
      assert_not revisa_sintaxis_expresion("0_")
      assert revisa_sintaxis_expresion(" Ñ\t")
      assert revisa_sintaxis_expresion("mujeres_lactantes")
      assert revisa_sintaxis_expresion("Actividades")
      assert revisa_sintaxis_expresion("fecha")
      assert revisa_sintaxis_expresion("Actividades_contribuyentes")
      assert revisa_sintaxis_expresion("Efectos_contribuyentes")
    end

    test "aplicación funcional" do
      # primera o primero o PRIMERA o PRIMERO: vector -> elemento
      # última o último o ÚLTIMA o ÚLTIMO: vector -> elemento
      # cuenta o CUENTA: vector -> numero
      # únicos o únicas o ÚNICOS o ÚNICAS: vector -> vector
      # suma o SUMA: vector de numeros -> numero
      # mapeaproy o MAPEAPROY: vector de objetos, nombre propiedad -> vector
      # aplana o APLANA: vector de vectores de objetos -> vector de objetos
      #   [[1,2], [3,4]] ->[1,2,3,4]
      assert revisa_sintaxis_expresion("primera(actividades)")
      assert revisa_sintaxis_expresion("primero(actividades)")
      assert revisa_sintaxis_expresion("ultima(actividades)")
      assert revisa_sintaxis_expresion("ultimo(actividades)")
      assert revisa_sintaxis_expresion("cuenta(actividades)")
      assert revisa_sintaxis_expresion("cuenta(actividades)")
      assert revisa_sintaxis_expresion("únicas(actividades)")
      assert revisa_sintaxis_expresion("únicos(actividades)")
      assert revisa_sintaxis_expresion("mapeaproy(actividades, poblacion)")
      assert revisa_sintaxis_expresion("suma(mapeaproy(actividades, poblacion))")
      # Cuenta de actividades
      assert revisa_sintaxis_expresion("cuenta(actividades)")
      # Cuenta población
      assert revisa_sintaxis_expresion("suma(mapa(actividades, poblacion))")
      # Cuenta asistentes
      assert revisa_sintaxis_expresion("cuenta(aplana(mapa(actividades, asistentes)))")
      # Cuenta asistentes únicos
      assert revisa_sintaxis_expresion("cuenta(unicos(aplana(mapa(actividades, asistentes))))")
      # Cuenta organizaciones
      assert revisa_sintaxis_expresion("cuenta(aplana(mapa(actividades, organizaciones)))")
      # Cuenta organizaciones únicas
      assert revisa_sintaxis_expresion("cuenta(unicos(aplana(mapa(actividades, organizaciones))))")
      assert revisa_sintaxis_expresion("cuenta(actividades)")
    end

    test "menos" do
      assert revisa_sintaxis_expresion("-cuenta(actividades)")
      assert revisa_sintaxis_expresion("-1")
      assert revisa_sintaxis_expresion("- 1,4")
    end

    # Operaciones binarias y paréntesis
    test "binarias y paréntesis" do
      assert revisa_sintaxis_expresion("(1)")
      assert revisa_sintaxis_expresion("(e)")
      assert revisa_sintaxis_expresion("1+2")
      assert revisa_sintaxis_expresion("1*2")
      assert revisa_sintaxis_expresion("1/2")
      assert revisa_sintaxis_expresion("1-2")
      assert revisa_sintaxis_expresion("1+x")
      assert revisa_sintaxis_expresion("x*100/50")
      assert revisa_sintaxis_expresion("x*(100/50)")
    end

    test "valor de propiedad" do
      assert revisa_sintaxis_expresion("primera(actividades).poblacion")
      assert revisa_sintaxis_expresion("ultima(actividades).fecha")
    end

    test "trienal_cinep_2021" do
      # O1I1, efecto, meta 20
      assert revisa_sintaxis_expresion(
        "cuenta(efectos_contribuyentes)",
      )

      # O1I2, efecto, meta 90
      assert revisa_sintaxis_expresion(
        'cuenta(unicas(listablanca(mapa(efectos_contribuyentes, organizacion),
          escuelas_rurales_linebase_2021)))*100/cuenta(escuelas_rurales_lineabase_2021)',
      )

      # O2I1, resultado, meta 5
      assert revisa_sintaxis_expresion(
        "cuenta(actividades_contribuyentes)",
      )

      # O2I2, efecto, meta 30
      assert revisa_sintaxis_expresion(
        "cuenta(mapa(efectos_contribuyentes, organizacion))",
      )

      # O3I1, efecto, meta 6
      assert revisa_sintaxis_expresion(
        "cuenta(efectos_contribuyentes)",
      )

      # O3I2, efecto, meta 60
      assert revisa_sintaxis_expresion(
        'cuenta(unicas(listablanca(mapa(efectos_contribuyentes, organizacion),
          municipios_pdet_linebase_2021)))*100/cuenta(municipios_pdet_lineabase_2021)',
      )
    end
  end  # class
end    # module
