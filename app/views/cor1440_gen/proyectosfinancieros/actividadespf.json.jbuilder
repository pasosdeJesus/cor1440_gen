json.array!(@registros) do |registro|
  json.id registro.id
  json.nombre (registro.presenta_nombre)
end

