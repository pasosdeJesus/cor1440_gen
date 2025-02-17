# frozen_string_literal: true

module Cor1440Gen
  module MedicionHelper
    # SINTAXIS. Basada en ejemplos:
    #   * https://kschiess.github.io/parslet/get-started.html
    #   * https://github.com/kschiess/parslet/blob/master/example/calc.rb
    #   * https://github.com/kschiess/parslet/blob/master/example/boolean_algebra.rb
    #   * https://en.wikipedia.org/wiki/Operator-precedence_parser
    # Referencia sintaxis de Excel:
    #   * https://fenia266781730.files.wordpress.com/2019/04/smrdoc.pdf
    class ExpMed < Parslet::Parser
      # Reglas de un caracter
      rule(:pareni)     { str("(") >> espacio? }
      rule(:parend)     { str(")") >> espacio? }
      rule(:coma)       { str(",") >> espacio? }

      rule(:espacio)   { match('\s').repeat(1) }
      rule(:espacio?)  { espacio.maybe }

      # Números positivos
      rule(:entero) do
        match("[0-9]").repeat(1).as(:num) >> espacio?
      end
      rule(:flotante) do
        (match("[0-9]").repeat(1) >> str(",") >>
         match(["0-9"]).repeat(1)).as(:num) >> espacio?
      end

      # Nombres
      rule(:ident) do
        match("[A-Za-z_ÁÉÍÓÚÜÑáéíóúüñ]") >>
          match("[A-Za-z_ÁÉÍÓÚÜÑáéíóúüñ0-9]").repeat(0)
      end

      # Aplicación funcional
      rule(:listaarg) { expresion >> (coma >> expresion).repeat }
      rule(:apfuncion) do
        ident.as(:apfuncion) >> espacio? >> pareni >>
          listaarg.as(:listaarg) >> parend
      end

      # Primario para tener en cuenta paréntesis y -
      rule(:expprimaria) do
        # (pareni >> expresion >> parend >> str('.') >>
        #  ident.as(:campo)).as(:proyeccion) |
        pareni >> expresion >> parend |
          # (apfuncion >> str('.') >> ident.as(:campo)).as(:proyeccion) |
          apfuncion |
          # (ident.as(:registro) >> str('.') >> ident.as(:campo)).as(:proyeccion) |
          ident.as(:identificador) >> espacio? |
          flotante |
          entero |
          (str("-") >> espacio? >> expprimaria.as(:exp)).as(:menos)
      end

      rule(:exppro) do
        (expprimaria.as(:registro) >> str(".") >> espacio? >>
         ident.as(:campo)).as(:proyeccion) |
          expprimaria
      end

      # Operaciones binarias
      rule(:opmult) { match["*/"].as(:o) >> espacio? }
      rule(:opadit) { match["+-"].as(:o) >> espacio? }

      rule(:expmultiplicativa) do
        (exppro.as(:izq) >> opmult >>
         expmultiplicativa.as(:der)).as(:opbin) |
          exppro
      end

      rule(:expaditiva) do
        (expmultiplicativa.as(:izq) >> opadit >>
         expaditiva.as(:der)).as(:opbin) |
          expmultiplicativa
      end

      rule(:expresion) do
        espacio? >> expaditiva
      end

      root :expresion
    end

    # ÁRBOL DE SINTAXIS ABSTRACTA Y SU EVALUACIÓN
    ###########################################

    LitNum = Struct.new(:num) do
      def eval(contexto, menserror = "".dup)
        num.to_s.sub(",", ".").to_f
      end
    end

    Menos = Struct.new(:e) do
      def eval(contexto, menserror = "".dup)
        -e.eval(contexto, menserror).to_f; end
    end

    Ident = Struct.new(:id) do
      def eval(contexto, menserror = "".dup)
        unless contexto
          STDERR.puts "** No se definió contexto"
          return
        end
        if !contexto[id.to_s] && !contexto[id.to_s.to_sym]
          STDERR.puts "** No se definió #{id} en contexto"
          return
        end
        contexto[id.to_s] || contexto[id.to_s.to_sym]
      end
    end

    ApFun = Struct.new(:fun, :argsp) do
      def eval(contexto, menserror = "".dup)
        # args que siempre sea vector con argumentos
        args = argsp.class.to_s != "Array" ? [argsp] : argsp
        # argsev contendrá evaluaciónd de los argumentos necesarios
        argsev = []
        case fun.to_s.localize.casefold.to_s

        when "aplana"
          if args.count != 1
            STDERR.puts "** Función #{fun} requiere un parámetro"
            return
          end
          argsev[0] = args[0].eval(contexto, menserror)
          unless argsev[0].respond_to?(:count)
            STDERR.puts "** Parámetro de función #{fun} no es vector"
            return
          end
          argsev[0].flatten

        when "cuenta"
          if args.count != 1
            STDERR.puts "** Función #{fun} requiere un parámetro"
            return
          end
          argsev[0] = args[0].eval(contexto, menserror)
          unless argsev[0].respond_to?(:count)
            STDERR.puts "** Parámetro de función #{fun} no es vector"
            return
          end
          argsev[0].count

        when "interseccion", "intersección"
          if args.count != 2
            STDERR.puts "** Función #{fun} requiere dos parámetros"
            return
          end
          argsev = args.map { |a| a.eval(contexto, menserror) }
          unless argsev[0].respond_to?(:count)
            STDERR.puts "** Primer parámetro de función #{fun} no es vector"
            return
          end
          unless argsev[0].respond_to?(:count)
            STDERR.puts "** Segundo parámetro de función #{fun} no es vector"
            return
          end

          argsev[0] && argsev[1] ? argsev[0] & argsev[1] : nil

        when "mapeaproy"
          if args.count != 2
            STDERR.puts "** Función #{fun} requiere dos parámetro"
            return
          end
          argsev[0] = args[0].eval(contexto, menserror)
          unless argsev[0].respond_to?(:count)
            STDERR.puts "** Primer parámetro de función #{fun} no es vector"
            return
          end
          if args[1].class != Ident
            STDERR.puts "** Segundo parámetro de función #{fun} debe ser identificador"
            return
          end
          argsev[1] = args[1].id.to_s
          menserror = "".dup
          m = argsev[0].map do |e|
            if e[argsev[1].to_sym]
              e[argsev[1].to_sym]
            elsif e[argsev[1]]
              e[argsev[1]]
            elsif !e.respond_to?(:evalua_campo)
              STDERR.puts "** La clase #{e.class} no tiene función " \
                "evalua_campo"
              nil
            else
              e.evalua_campo(argsev[1], menserror)
            end
          end
          m

        when "primera", "primer", "primero"
          if args.count != 1
            STDERR.puts "** Función #{fun} requiere un parámetro"
            return
          end
          argsev[0] = args[0].eval(contexto, menserror)
          unless argsev[0].respond_to?(:count)
            STDERR.puts "** Parámetro de función #{fun} no es vector"
            return
          end
          if !argsev[0].count == 0
            STDERR.puts "** Parámetro de función #{fun} es vector vacío"
            return
          end
          argsev[0][0]

        when "suma"
          if args.count != 1
            STDERR.puts "** Función #{fun} requiere un parámetro"
            return
          end
          argsev[0] = args[0].eval(contexto, menserror)
          unless argsev[0].respond_to?(:count)
            STDERR.puts "** Primer parámetro de función #{fun} no es vector"
            return
          end
          argsev[0].inject(0) do |memo, e|
            memo + e.to_f
          end

        when "únicos", "unicos", "únicas", "unicas"
          if args.count != 1
            STDERR.puts "** Función #{fun} requiere un parámetro"
            return
          end
          argsev[0] = args[0].eval(contexto, menserror)
          unless argsev[0].respond_to?(:uniq)
            STDERR.puts "** Parámetro de función #{fun} no es vector"
            return
          end
          argsev[0].uniq
          # {|e|
          #   if r.class != Array && r.class != Integer && r.class != Float &&
          #       r.class != Date
          #     r = e['id'] || e[:id]
          #   else
          #     r = e
          #   end
          #   return r
          # }

        end
      end
    end

    Proy = Struct.new(:registro, :campo) do
      def eval(contexto, menserror = "".dup)
        r = registro.eval(contexto, menserror)
        c = campo.to_s
        if r.nil?
          STDERR.puts "** Evaluacion de registro dió nil"
          return
        end
        menserror = "".dup
        if r[c]
          r[c]
        elsif r[c.to_sym]
          r[c.to_sym]
        elsif !r.respond_to?(:evalua_campo)
          STDERR.puts "** La clase #{e.class} no tiene función " \
            "evalua_atributo"
          nil
        else
          e.evalua_atributo(argsev[1], menserror)
        end

        if r[c] || r[c.to_sym]
          r[c] ? r[c] : r[c.to_sym]
        else
          STDERR.puts "** #{registro} no tiene campo #{c}"
          nil
        end
      end
    end

    OpBin = Struct.new(:izq, :op, :der) do
      def eval(contexto, menserror = "".dup)
        eizq = izq.eval(contexto, menserror)
        eder = der.eval(contexto, menserror)
        case op
        when "+"
          eizq + eder
        when "-"
          eizq - eder
        when "*"
          eizq * eder
        when "/"
          if eder == 0
            STDERR.puts "** División entre 0"
            return
          end
          eizq / eder
        else
          STDERR.puts "** Operación '#{op}' desconocida"
          nil
        end
      end
    end

    # TRANSFORMACIÓN DE SINTAXIS CONCRETA A ÁRBOL DE SINTAXIS ABSTRACTA
    class ExpMedT < Parslet::Transform
      rule(num: simple(:num))          { LitNum.new(num) }
      rule(identificador: simple(:id)) { Ident.new(id) }
      rule(menos: { exp: subtree(:exp) }) { Menos.new(exp) }
      rule(
        apfuncion: simple(:fun),
        listaarg: subtree(:listaarg),
      ) { ApFun.new(fun, listaarg) }
      rule(
        proyeccion: {
          registro: subtree(:registro),
          campo: simple(:campo),
        },
      ) { Proy.new(registro, campo) }
      rule(
        opbin: {
          izq: subtree(:izq),
          o: simple(:op),
          der: subtree(:der),
        },
      ) { OpBin.new(izq, op, der) }
    end

    def revisa_sintaxis_expresion(e, menserror = "".dup)
      reconocedor = ExpMed.new
      reconocedor.parse(e)
      true
    rescue Parslet::ParseFailed => falla
      menserror << ("Error de sintaxis en expresión '#{e}'. " +
        "<pre>#{falla.parse_failure_cause.ascii_tree}</pre>.  ".html_safe)
      STDERR.puts "** #{e}"
      STDERR.puts falla.parse_failure_cause.ascii_tree
      false
    end
    module_function :revisa_sintaxis_expresion

    def revisa_sintaxis_filtro(e)
      false
    end
    module_function :revisa_sintaxis_filtro

    # Evalua una expresión en un contexto dado
    # @return nil si tiene problemas y los describe en menserror
    def evalua_expresion_medicion(e, contexto, menserror = "".dup)
      r = ExpMed.new
      p = r.parse(e)
      t = ExpMedT.new
      asa = t.apply(p)
      res = asa.eval(contexto, menserror)
      res
    rescue Parslet::ParseFailed => falla
      menserror << ("Error de sintaxis en expresión '#{e}'. " +
        "<pre>#{falla.parse_failure_cause.ascii_tree}</pre>.  ".html_safe)
      STDERR.puts "** #{e}"
      STDERR.puts falla.parse_failure_cause.ascii_tree
      nil
    end
    module_function :evalua_expresion_medicion
  end
end
