module Cor1440Gen
  module ConteosHelper

    # Da conteo de asistentes a un actividad como una tabla
    # por Rango de Edad y Sexo
    # @return diccionario primer índice es id de rango de edad,
    #         segundo índice es sexo ('F', 'M' o 'S')  (o el de
    #         la convención de la base de datos en ese orden).
    def genera_dicc_poblacion_de_asistentes(a)

      personas = {}
      a.asistencia.each do |asist|
        if personas[asist.persona.id]
          STDERR.puts "Persona #{asist.persona.id} repetida en listado de asistencia de la actividad #{a.id}"
        else
          personas[asist.persona.id] = 1
        end
      end

      convF = Sip::Persona.convencion_sexo_abreviada[0]
      convM = Sip::Persona.convencion_sexo_abreviada[1]
      convS = Sip::Persona.convencion_sexo_abreviada[2]
      rangoedadsexo = {}
      personas.keys.sort.each do |pid|
        p = Sip::Persona.find(pid)
        edad = Sivel2Gen::RangoedadHelper.edad_de_fechanac_fecha(
          p.anionac, p.mesnac, p.dianac,
          a.fecha.year, a.fecha.month, a.fecha.day)
        re = Sivel2Gen::RangoedadHelper.buscar_rango_edad(
          edad, 'Cor1440Gen::Rangoedadac')
        if !rangoedadsexo[re]
          rangoedadsexo[re] = {}
          rangoedadsexo[re][convF] = 0
          rangoedadsexo[re][convM] = 0
          rangoedadsexo[re][convS] = 0
        end
        rangoedadsexo[re][p.sexo] += 1
      end

      return rangoedadsexo
    end
    module_function :genera_dicc_poblacion_de_asistentes


    # Compara talba de población almacenada en base con la
    # que se genera del listado de asistencia
    # @return número de diferencias encontradas
    def compara_tabla_poblacion_asistentes_actividad(a)
      d = genera_dicc_poblacion_de_asistentes(a)

      numdif = 0

      convF = Sip::Persona.convencion_sexo_abreviada[0]
      convM = Sip::Persona.convencion_sexo_abreviada[1]
      convS = Sip::Persona.convencion_sexo_abreviada[2]

      res = Cor1440Gen::Rangoedadac.habilitados
      res.each do |re|
        tm = 0
        tf = 0
        ts = 0
        if a.actividad_rangoedadac && a.actividad_rangoedadac[re.id]
          tm = a.actividad_rangoedadac[re.id].mr
          tf = a.actividad_rangoedadac[re.id].fr
          ts = a.actividad_rangoedadac[re.id].s
        end
        dm = 0
        df = 0
        ds = 0
        if d[re.id]
          dm = d[re.id][convM]
          df = d[re.id][convF]
          ds = d[re.id][convS]
        end

        if tf != df 
          STDERR.puts "** Diferencia en actividad #{a.id}, "\
            "rango de edad #{re.id}, sexo #{convF}. "\
              "Tabla dice #{tf} y cuenta de asistentes da #{df}."
          numdif += 1
        end
        if tm != dm 
          STDERR.puts "** Diferencia en actividad #{a.id}, "\
            "rango de edad #{re.id}, sexo #{convM}. "\
            "Tabla dice #{tm} y cuenta de asistentes da #{dm}."
          numdif += 1
        end
        if ts != ds 
          STDERR.puts "** Diferencia en actividad #{a.id}, "\
            "rango de edad #{re.id}, sexo #{convS}. "\
            "Tabla dice #{ts} y cuenta de asistentes da #{ds}."
          numdif += 1
        end
      end

      return numdif
    end
    module_function :compara_tabla_poblacion_asistentes_actividad


    # Arregla tabla de población almacenada en base a partir
    # del listado de asistencia.
    # @return número de cambios efectuados 
    def arregla_tabla_poblacion_de_asistentes_actividad(a)
      d = genera_dicc_poblacion_de_asistentes(a)

      numdif = 0

      convF = Sip::Persona.convencion_sexo_abreviada[0]
      convM = Sip::Persona.convencion_sexo_abreviada[1]
      convS = Sip::Persona.convencion_sexo_abreviada[2]

      res = Cor1440Gen::Rangoedadac.habilitados
      res.each do |re|
        tm = 0
        tf = 0
        ts = 0
        if a.actividad_rangoedadac && a.actividad_rangoedadac[re.id]
          tm = a.actividad_rangoedadac[re.id].mr
          tf = a.actividad_rangoedadac[re.id].fr
          ts = a.actividad_rangoedadac[re.id].s
        end
        dm = 0
        df = 0
        ds = 0
        if d[re.id]
          dm = d[re.id][convM]
          df = d[re.id][convF]
          ds = d[re.id][convS]
        end

        if tf != df 
          if a.actividad_rangoedadac[re.id]
            a.actividad_rangoedadac[re.id].fr = df
          a.actividad_rangoedadac[

          STDERR.puts "** Diferencia en actividad #{a.id}, "\
            "rango de edad #{re.id}, sexo #{convF}. "\
              "Tabla dice #{tf} y cuenta de asistentes da #{df}."
          numdif += 1
        end
        if tm != dm 
          STDERR.puts "** Diferencia en actividad #{a.id}, "\
            "rango de edad #{re.id}, sexo #{convM}. "\
            "Tabla dice #{tm} y cuenta de asistentes da #{dm}."
          numdif += 1
        end
        if ts != ds 
          STDERR.puts "** Diferencia en actividad #{a.id}, "\
            "rango de edad #{re.id}, sexo #{convS}. "\
            "Tabla dice #{ts} y cuenta de asistentes da #{ds}."
          numdif += 1
        end
      end

      return numdif
    end
    module_function :compara_tabla_poblacion_asistentes_actividad



    # Compara tablas de población de todas las actividaddes
    # con conteos generados de asistentes
    # @return número de diferencias encontradas
    def compara_tablas_poblacion_asistentes()
      numdif = 0
      Cor1440Gen::Actividad.all.each do |a|
        numdif += compara_tabla_poblacion_asistentes_actividad(a)
      end
      
      STDERR.puts "Total de diferencias: #{numdif}"
      return numdif
    end
    module_function :compara_tablas_poblacion_asistentes


  end
end
