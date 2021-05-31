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
      rule(:pareni)     { str('(') >> espacio? }
      rule(:parend)     { str(')') >> espacio? }
      rule(:coma)       { str(',') >> espacio? }

      rule(:espacio)   { match('\s').repeat(1) }
      rule(:espacio?)  { espacio.maybe }

      # Números positivos
      rule(:entero) { 
        match('[0-9]').repeat(1).as(:num) >> espacio? 
      }
      rule(:flotante) { 
        (match('[0-9]').repeat(1) >> str(',') >> 
         match(['0-9']).repeat(1)).as(:num) >> espacio? 
      }

      # Nombres
      rule(:ident) { 
        match('[A-Za-z_ÁÉÍÓÚÜÑáéíóúüñ]') >>
        match('[A-Za-z_ÁÉÍÓÚÜÑáéíóúüñ0-9]').repeat(0)
      }

      # Aplicación funcional
      rule(:listaarg)    { expresion >> (coma >> expresion).repeat }
      rule(:apfuncion)    { 
        ident.as(:apfuncion) >> espacio? >> pareni >> 
        listaarg.as(:listaarg) >> parend 
      }

      # Primario para tener en cuenta paréntesis y -
      rule(:expprimaria) {
        #(pareni >> expresion >> parend >> str('.') >> 
        #  ident.as(:campo)).as(:proyeccion) | 
        pareni >> expresion >> parend | 
        #(apfuncion >> str('.') >> ident.as(:campo)).as(:proyeccion) |
        apfuncion |
        #(ident.as(:registro) >> str('.') >> ident.as(:campo)).as(:proyeccion) |
        ident.as(:identificador) >> espacio? |
        flotante |
        entero |
        (str("-") >> espacio? >> expprimaria.as(:exp)).as(:menos)
      }

      rule(:exppro) {
        (expprimaria.as(:registro) >> str('.') >> espacio? >> 
         ident.as(:campo)).as(:proyeccion) |
        expprimaria 
      }

      # Operaciones binarias
      rule(:opmult) { match['*/'].as(:o) >> espacio? }
      rule(:opadit) { match['+-'].as(:o) >> espacio? }

      rule(:expmultiplicativa) {
        (exppro.as(:izq) >> opmult >> 
         expmultiplicativa.as(:der)).as(:opbin) | 
        exppro
      }

      rule(:expaditiva) {
        (expmultiplicativa.as(:izq) >> opadit >> 
         expaditiva.as(:der)).as(:opbin) | 
        expmultiplicativa
      }
     
      rule(:expresion) {
        espacio? >> expaditiva
      }

      root :expresion
    end


    # ÁRBOL DE SINTAXIS ABSTRACTA Y SU EVALUACIÓN
    ###########################################

    LitNum= Struct.new(:num) do
      def eval(contexto); num.to_s.sub(',', '.').to_f; end
    end


    Menos = Struct.new(:e) do
      def eval(contexto); 
        -(e.eval(contexto).to_f); end
    end

    Ident = Struct.new(:id) do
      def eval(contexto)
        if !contexto
          STDERR.puts "** No se definió contexto"
          return nil
        end
        if !contexto[id.to_s] && !contexto[id.to_s.to_sym]
          STDERR.puts "** No se definió #{id.to_s} en contexto"
          return nil
        end
        return contexto[id.to_s] || contexto[id.to_s.to_sym]
      end
    end

    ApFun = Struct.new(:fun, :argsp) do
      def eval(contexto)
        # args que siempre sea vector con argumentos
        args = argsp.class.to_s != 'Array' ? [argsp] : argsp
        # argsev contendrá evaluaciónd de los argumentos necesarios
        argsev = []
        case fun.to_s.localize.casefold.to_s

        when 'aplana'
          if args.count != 1
            STDERR.puts "** Función #{fun.to_s} requiere un parámetro"
            return nil
          end
          argsev[0] = args[0].eval(contexto)
          if !argsev[0].respond_to?(:count)
            STDERR.puts "** Parámetro de función #{fun.to_s} no es vector"
            return nil
          end
          return argsev[0].flatten


        when 'cuenta'
          if args.count != 1
            STDERR.puts "** Función #{fun.to_s} requiere un parámetro"
            return nil
          end
          argsev[0] = args[0].eval(contexto)
          if !argsev[0].respond_to?(:count)
            STDERR.puts "** Parámetro de función #{fun.to_s} no es vector"
            return nil
          end
          return argsev[0].count

        when 'interseccion', 'intersección'
          if args.count != 2
            STDERR.puts "** Función #{fun.to_s} requiere dos parámetros"
            return nil
          end
          argsev = args.map{|a| a.eval(contexto)}
          if !argsev[0].respond_to?(:count)
            STDERR.puts "** Primer parámetro de función #{fun.to_s} no es vector"
            return nil
          end
          if !argsev[0].respond_to?(:count)
            STDERR.puts "** Segundo parámetro de función #{fun.to_s} no es vector"
            return nil
          end

          return argsev[0] && argsev[1] ? argsev[0] & argsev[1] : nil


        when 'mapeaproy'
          if args.count != 2
            STDERR.puts "** Función #{fun.to_s} requiere dos parámetro"
            return nil
          end
          argsev[0] = args[0].eval(contexto)
          if !argsev[0].respond_to?(:count)
            STDERR.puts "** Primer parámetro de función #{fun.to_s} no es vector"
            return nil
          end
          if args[1].class != Ident
            STDERR.puts "** Segundo parámetro de función #{fun.to_s} debe ser identificador"
            return nil
          end
          argsev[1] = args[1].id.to_s
          return argsev[0].map{|e|
            e[argsev[1].to_sym] || e[argsev[1].to_s] 
          }

        when 'primera', 'primer', 'primero'
          if args.count != 1
            STDERR.puts "** Función #{fun.to_s} requiere un parámetro"
            return nil
          end
          argsev[0] = args[0].eval(contexto)
          if !argsev[0].respond_to?(:count)
            STDERR.puts "** Parámetro de función #{fun.to_s} no es vector"
            return nil
          end
          if !argsev[0].count == 0
            STDERR.puts "** Parámetro de función #{fun.to_s} es vector vacío"
            return nil
          end
          return argsev[0][0]

        when 'suma'
          if args.count != 1
            STDERR.puts "** Función #{fun.to_s} requiere un parámetro"
            return nil
          end
          argsev[0] = args[0].eval(contexto)
          if !argsev[0].respond_to?(:count)
            STDERR.puts "** Primer parámetro de función #{fun.to_s} no es vector"
            return nil
          end
          return argsev[0].inject(0){|memo, e| 
            memo + e.to_f
          }


        when 'únicos', 'unicos', 'únicas', 'unicas'
          if args.count != 1
            STDERR.puts "** Función #{fun.to_s} requiere un parámetro"
            return nil
          end
          argsev[0] = args[0].eval(contexto)
          if !argsev[0].respond_to?(:uniq)
            STDERR.puts "** Parámetro de función #{fun.to_s} no es vector"
            return nil
          end
          return argsev[0].uniq
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
      def eval(contexto)
        r = registro.eval(contexto)
        c = campo.to_s
        if r && (r[c] || r[c.to_sym])
          return r[c] ? r[c] : r[c.to_sym]
        else
          STDERR.puts "** #{registro.to_s} no tiene campo #{c}"
          return nil
        end
      end
    end


    OpBin = Struct.new(:izq, :op, :der) do
      def eval(contexto)
        eizq = izq.eval(contexto)
        eder = der.eval(contexto)
        case op
        when '+'
          return eizq + eder
        when '-'
          return eizq - eder
        when '*'
          return eizq * eder
        when '/'
          if eder == 0
            STDERR.puts "** División entre 0"
            return nil
          end
          return eizq / eder
        else
          STDERR.puts "** Operación '#{op}' desconocida"
          return nil
        end
      end
    end


    # TRANSFORMACIÓN DE SINTAXIS CONCRETA A ÁRBOL DE SINTAXIS ABSTRACTA
    class ExpMedT < Parslet::Transform
      rule(:num => simple(:num))          { LitNum.new(num) }
      rule(:identificador => simple(:id)) { Ident.new(id) }
      rule(:menos => { :exp => subtree(:exp)})        { Menos.new(exp) }
      rule(
        :apfuncion => simple(:fun), 
        :listaarg => subtree(:listaarg))  { ApFun.new(fun, listaarg) }
      rule(
        :proyeccion => { 
          :registro=> subtree(:registro),
          :campo => simple(:campo) } )    {Proy.new(registro, campo)}
      rule(
        :opbin => {
          :izq => subtree(:izq), 
          :o => simple(:op),
          :der => subtree(:der) } )       { OpBin.new(izq, op, der) }
    end


    def revisa_sintaxis_expresion(e)
      reconocedor = ExpMed.new
      p = reconocedor.parse(e)
      return true
    rescue Parslet::ParseFailed => falla
      STDERR.puts "** #{e}"
      STDERR.puts falla.parse_failure_cause.ascii_tree
      return false
    end
    module_function :revisa_sintaxis_expresion


    def revisa_sintaxis_filtro(e)
      return false
    end
    module_function :revisa_sintaxis_filtro


    def evalua_expresion_medicion(e, contexto)
      r = ExpMed.new
      p = r.parse(e)
      t = ExpMedT.new
      asa = t.apply(p)
      res = asa.eval(contexto)
      return res
    rescue Parslet::ParseFailed => falla
      STDERR.puts "** #{e}"
      STDERR.puts falla.parse_failure_cause.ascii_tree
      return false
    end
    module_function :evalua_expresion_medicion


  end
end
