# encoding: UTF-8

require_relative '../../test_helper'
require 'cor1440_gen/medicion_helper'

module Cor1440Gen
  class EvaluacionMedicionHelperTest < ActionView::TestCase

    include MedicionHelper

    # La evaluación requiere un contexto donde se 
    # definen identificadores con datos
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
    #   3. Una tabla (e.g Actividades, Organizaciones, Personas, Proyectos)
    #   4. Otros definidos en ruby, por lo menos:
    #     * Actividades_contribuyentes Actividades que aportan a un indicador de
    #       resultado
    #     * Efectos_contribuyentes Actividades que aportan a un indicador de
    #       efecto
    test "números e identificadores" do
      # números
      assert_equal 1.0, evalua_expresion_medicion(' 1 ', nil)
      assert_equal 1.0, evalua_expresion_medicion("\n1,0\t", nil)
      assert_equal -2.0, evalua_expresion_medicion('-2', nil)
      assert_equal -2.0, evalua_expresion_medicion("-2,0", nil)
      # identificadores
      assert_nil evalua_expresion_medicion("m", nil)
      assert_equal 1.0, evalua_expresion_medicion("m", {'m' => 1.0})
      assert_equal -1.0, evalua_expresion_medicion("-m", {'m' => 1.0})
      # paréntesis
      assert_equal 1.0, evalua_expresion_medicion("(m)", {'m' => 1.0})
      assert_equal -1.0, evalua_expresion_medicion("-(m)", {'m' => 1.0})
      assert_equal -1.0, evalua_expresion_medicion("(-m)", {'m' => 1.0})
    end

    test "aplicación funcional" do
      # los nombres de funciones no son sensibles a capitalización 
      # --por si prefieren SUMA y otras estilo Excel
      #
      # primera o primero o primer : vector -> elemento
      # última o último o ÚLTIMA o ÚLTIMO: vector -> elemento
      # cuenta o CUENTA: vector -> numero
      # únicos o únicas o ÚNICOS o ÚNICAS: vector -> vector (por el
      #   momento en registros chequea profundamente que sean iguales).
      # suma o SUMA: vector de numeros -> numero
      # mapeaproy o MAPEAPROY: vector de objetos, nombre propiedad -> vector 
      # aplana o APLANA: vector de vectores de objetos -> vector de objetos
      #   [[1,2], [3,4]] ->[1,2,3,4]
      # intersección  retorna elementos comunes a 2 vectores sin repetición
      #
      # Función cuenta
      assert_equal 0, evalua_expresion_medicion(
        "cuenta(Actividades)", 
        {'Actividades' => []}
      )
      assert_equal 1, evalua_expresion_medicion(
        "cuenta(Actividades)", 
        {'Actividades' => [1]}
      )
      # proyeccion
      assert_equal 5, evalua_expresion_medicion(
        "a.población", 
        {'a' => {'población' => 5}}
      )
      # Función primera
      assert_equal 5, evalua_expresion_medicion(
        "primera(Actividades).población", 
        {'Actividades' => [{'población' => 5}]}
      )
      assert_equal 6, evalua_expresion_medicion(
        "PRIMERO(Actividades).población", 
        {'Actividades' => [{'población' => 6}]}
      )

      # Función únicos
      assert_equal 1, evalua_expresion_medicion(
        'cuenta(únicos(Actividades))',
        {'Actividades' => [1, 1]}
      )
      assert_equal 2, evalua_expresion_medicion(
        'cuenta(únicos(Actividades))',
        {'Actividades' => [{id:1, otro:2}, {id:1, otro: 3}]}
      )

      # Función mapeaproy
      assert_equal [2,3], evalua_expresion_medicion(
        'mapeaproy(Actividades, poblacion)',
        {'Actividades' => [{poblacion: 2}, {poblacion: 3}]}
      )

      # Función suma
      assert_equal 5, evalua_expresion_medicion(
        'suma(mapeaproy(Actividades, poblacion))',
        {'Actividades' => [{poblacion: 2}, {poblacion: 3}]}
      )

      # Función aplana
      assert_equal [1,2,3,4], evalua_expresion_medicion(
        'aplana(mapeaproy(Actividades, Asistentes))',
        {'Actividades' => [{Asistentes: [1, 2]}, {Asistentes: [3, 4]}]}
      )
      assert_equal [1,2,2,1], evalua_expresion_medicion(
        'aplana(mapeaproy(Actividades, Asistentes))',
        {'Actividades' => [{Asistentes: [1, 2]}, {Asistentes: [2, 1]}]}
      )

      # Función intersección
      assert_equal [2], evalua_expresion_medicion(
        'intersección(Actividades1, Actividades2)',
        {Actividades1: [1,2,2,3],
         Actividades2: [2,4,2,6]}
      )

      # Cuenta asistentes
      assert_equal 4, evalua_expresion_medicion(
        'cuenta(aplana(mapeaproy(Actividades, Asistentes)))',
        {'Actividades' => [{Asistentes: [1, 2]}, {Asistentes: [2, 1]}]}
      )

      # Cuenta asistentes únicos
      assert_equal 2, evalua_expresion_medicion(
        'cuenta(unicos(aplana(mapeaproy(Actividades, Asistentes))))',
        {'Actividades' => [{Asistentes: [1, 2]}, {Asistentes: [2, 1]}]}
      )

      # Cuenta organizaciones
      assert_equal 2, evalua_expresion_medicion(
        'cuenta(aplana(mapeaproy(Actividades, Organizaciones)))',
        {'Actividades' => [{Asistentes: [1, 2], Organizaciones: [5]}, 
                           {Asistentes: [2, 1], Organizaciones: [5]}]}
      )
      # Cuenta organizaciones únicas
      assert_equal 1, evalua_expresion_medicion(
        'cuenta(unicas(aplana(mapeaproy(Actividades, Organizaciones))))',
        {'Actividades' => [{Asistentes: [1, 2], Organizaciones: [5]}, 
                           {Asistentes: [2, 1], Organizaciones: [5]}]}
      )

    end

    # Operaciones binarias y paréntesis
    test "binarias y paréntesis" do
      assert_equal 1, evalua_expresion_medicion('(1)', nil)
      assert_equal 2, evalua_expresion_medicion('(e)', {'e' => 2})
      assert_equal 3, evalua_expresion_medicion('1+2', nil)
      assert_equal 2, evalua_expresion_medicion('1*2', nil)
      assert_equal 0.5, evalua_expresion_medicion('1/2', nil)
      assert_equal -1, evalua_expresion_medicion('1-2', nil)
      assert_equal 2, evalua_expresion_medicion('1+x', {'x' => 1})
      assert_equal 2, evalua_expresion_medicion('x*100/50', {'x' => 1})
      assert_equal 2, evalua_expresion_medicion('x*(100/50)', {'x' => 1})
    end


    test "trienal_cinep_2021" do
      # O1I1, efecto, meta 20
      assert_equal 3, evalua_expresion_medicion(
        'cuenta(Efectos_contribuyentes)',
        {Efectos_contribuyentes: [{}, {}, {}]}
      )

      # O1I2, efecto, meta 90
      con = {
        Efectos_contribuyentes: [
          {Organizaciones: [{id: 1}, {id: 2}]}, 
          {Organizaciones: [{id: 2}, {id: 3}]}
        ],
        Escuelas_rurales_lineabase_2021: [
          {id: 2}, {id: 3}, {id: 4}, {id: 5}
        ]
      }

      assert_equal [ [{id: 1}, {id: 2}], [{id: 2}, {id: 3}] ],
        evalua_expresion_medicion(
          'mapeaproy(Efectos_contribuyentes, Organizaciones)', con
      )
      assert_equal [ {id: 1}, {id: 2}, {id: 2}, {id: 3} ],
        evalua_expresion_medicion(
        'aplana(mapeaproy(Efectos_contribuyentes, Organizaciones))', con)

      assert_equal [ {id: 2}, {id: 3} ],
        evalua_expresion_medicion(
        'intersección(
          aplana(mapeaproy(Efectos_contribuyentes, Organizaciones)), 
          Escuelas_rurales_lineabase_2021)', con)


      assert_equal 50, evalua_expresion_medicion(
        'cuenta(
          intersección(
            aplana(mapeaproy(Efectos_contribuyentes, Organizaciones)), 
            Escuelas_rurales_lineabase_2021
          )
         )*100/cuenta(Escuelas_rurales_lineabase_2021)', con)

      # O2I1, resultado, meta 5
       assert_equal 3, evalua_expresion_medicion(
        'cuenta(Actividades_contribuyentes)',
        {Actividades_contribuyentes: [{id: 1}, {id: 2}, {id: 3}]}
       )

      # O2I2, efecto, meta 30
      con = {
        Efectos_contribuyentes:[
          {Organizaciones: [{id: 1}]},
          {Organizaciones: [{id: 2}, {id: 1}]}
        ]
      }
      assert_equal 2, evalua_expresion_medicion(
        'cuenta(
          únicas(
            mapeaproy(Efectos_contribuyentes, Organizaciones)
          )
        )', con
      )

      # O3I1, efecto, meta 6
      assert_equal true, revisa_sintaxis_expresion(
        'cuenta(efectos_contribuyentes)'
      )

      # O3I2, efecto, meta 60
      assert_equal true, revisa_sintaxis_expresion(
        'cuenta(unicas(listablanca(mapa(efectos_contribuyentes, organizacion), 
          municipios_pdet_linebase_2021)))*100/cuenta(municipios_pdet_lineabase_2021)'
      )
    end

  end  # class
end    # module
