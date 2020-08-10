
# Medición de indicadores de resultado


1. Cree un tipo de indicador que se mida con actividades y que describa para usuarios el resultado y los datos intermedios que retorna la función, así como la evidencia para resultado y la evidencia para los datos intermedios.
2. En las fuentes de su aplicación en `controllers/cor1440_gen/mindicadorespf_controller.rb` cree una  `medir_indicador_res_tipo_x` donde x es el número del tipo de indicador que creó en el punto 1

Tal función es de la forma:
```rb
  # Mide indicador de resultado tipo 4. Cantidad de asistentes únicos
# en listados de asistencia. No incluye repetidos
# Los datos intermedios que retorna son mujeres únicas, 
# hombres únicos y sin sexo de nacimiento únicos
# La  evidencia que retorna en cada caso es lista de mujeres,
# lista de hombres y lista de sin sexo de nacimiento.
def medir_indicador_res_tipo_4(idacs, mind, fini, ffin)
  datosint = []
  mujeres = asistencia_por_sexo(idacs, 'F', true)
  hombres = asistencia_por_sexo(idacs, 'M', true)
  sinsexo = asistencia_por_sexo(idacs, 'S', true)
  resind =  mujeres.count + hombres.count + sinsexo.count
  datosint << {valor: mujeres.count, rutaevidencia: '#'}
  datosint << {valor: hombres.count, rutaevidencia: '#'}
  datosint << {valor: sinsexo.count, rutaevidencia: '#'}
  if datosint[0][:valor] > 0 # mujeres
      datosint[0][:] = sip.personas_path+ '?filtro[busid]=' +
        mujeres.join(',')
    end
    if datosint[1][:valor] > 0 # hombres
      datosint[1][:] = sip.personas_path+ '?filtro[busid]=' +
        hombres.join(',')
    end
    if datosint[2][:valor] > 0 # sin sexo nac
      datosint[2][:] = sip.personas_path+ '?filtro[busid]=' +
        sinsexo.join(',')
    end

  return {resind: resind, datosint: datosint}
end
```


# Medición de indicadores de efecto mediante avances en efecto

1. Cree un tipo de indicador que se mida con avance en efectos y que describa para usuarios el resultado y los datos intermedios que retorna la función, así como la evidencia para el resultado y la evidencia para los datos intermedios.
2. En las fuentes de su aplicación en `controllers/cor1440_gen/mindicadorespf_controller.rb` cree una función `medir_indicador_efecto_tipo_x` donde x es el número del tipo de indicador que creó en el punto 1

Tal función es de la forma:
```rb
# idefs Es lista con identificación de los efectos que aportan en el avance
# mind Es objeto Cor1440Gen::Mindicadorpf instanciado a la medición que se hace
# fini Es fecha inicial de medición
# ffin Es fecha final de medición
def medir_indicador_efecto_tipo_10(idefs, mind, fini, ffin)
 return {resind: idefs.count, datosint: []}
end
