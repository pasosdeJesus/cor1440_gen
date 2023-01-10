# frozen_string_literal: true

json.array!(@registros) do |registro|
  json.id(registro.id)
  json.nombre(registro.numero + ": " + registro.objetivo)
end
