json.array!(@registros) do |registro|
  json.id registro.id
  json.nombre (registro.nombrecorto + ' ' + registro.titulo)
end

