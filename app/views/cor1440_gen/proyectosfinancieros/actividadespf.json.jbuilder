json.array!(@registros) do |registro|
  json.id registro.id
  json.nombre (registro.resultadopf.numero + registro.nombrecorto + ' ' + registro.titulo)
end

