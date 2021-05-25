module Cor1440Gen
  module MedicionHelper


    # Referencia sintaxis de Excel: https://fenia266781730.files.wordpress.com/2019/04/smrdoc.pdf

    # Basado en ejemplo de https://kschiess.github.io/parslet/get-started.html
    class ExpMed < Parslet::Parser
      # Reglas de un caracter
      rule(:pareni)     { str('(') >> espacio? }
      rule(:parend)     { str(')') >> espacio? }
      rule(:coma)       { str(',') >> espacio? }

      rule(:espacio)   { match('\s').repeat(1) }
      rule(:espacio?)  { espacio.maybe }

      # elementos de una expresión
      rule(:numero)         { match('[0-9.]').repeat(1).as(:num) >> espacio? }
      rule(:iden)  { match('[a-z_.]').repeat(1) }
      rule(:operador)       { match('[-+*/]') >> espacio? }

      rule(:expmin) { numero | iden }

      # Partes de gramática
      rule(:opbin)        { 
        expmin.as(:izq) >> operador.as(:op) >> expresion.as(:der) }
      rule(:listaarg)    { expresion >> (coma >> expresion).repeat }
      rule(:funcion)    { 
        iden.as(:funcion) >> pareni >> listaarg.as(:listaarg) >> parend }
      rule(:identificador)    { 
        iden.as(:identificador) }

      rule(:expresion) { funcion | opbin | numero | identificador }
      root :expresion
    end

    LitEnt = Struct.new(:num) do
      def eval; num.to_f; end
    end
    Suma = Struct.new(:izq, :der) do
      def eval; izq.eval + der.eval; end
    end
    Resta = Struct.new(:izq, :der) do
      def eval; izq.eval - der.eval; end
    end
    Multiplicacion = Struct.new(:izq, :der) do
      def eval; izq.eval * der.eval; end
    end
    Division = Struct.new(:izq, :der) do
      def eval; der.eval == 0 ? 0 : izq.eval / der.eval; end
    end
    LlamadFunl = Struct.new(:name, :args) do
      def eval; p args.map { |s| s.eval }; end
    end

    class ExpMedT < Parslet::Transform
      rule(:num=> simple(:num))        { LitEnt.new(num) }
      rule(
        :izq => simple(:izq), 
        :der => simple(:der), 
        :op => '+')                     { Suma.new(izq, der) }
      rule(
        :izq => simple(:izq), 
        :der => simple(:der), 
        :op => '-')                     { Resta.new(izq, der) }
      rule(
        :izq => simple(:izq), 
        :der => simple(:der), 
        :op => '*')                     { Multiplicacion.new(izq, der) }
      rule(
        :izq => simple(:izq), 
        :der => simple(:der), 
        :op => '/')                     { Division.new(izq, der) }
      rule(
        :funcion => 'puts', 
        :listaarg => subtree(:listaarg))  { LlamadFunl.new('puts', listaarg) }
    end


    def revisa_sintaxis_expresion(e)
      reconocedor = ExpMed.new
      begin
        p = reconocedor.parse(e)
      rescue
        return false
      end
      return true
    end
    module_function :revisa_sintaxis_expresion


    def revisa_sintaxis_filtro(e)
      return false
    end
    module_function :revisa_sintaxis_filtro


    def evalua_expresion(e)
      reconocedor = ExpMed.new
      p = reconocedor.parse(e)
      transf = ExpMedT.new
      asa = transf.apply(p)
      r = asa.eval 
      return r
    end
    module_function :evalua_expresion


  end
end
