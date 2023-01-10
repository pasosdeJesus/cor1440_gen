# frozen_string_literal: true

json.extract!(
  @actividad,
  :numero,
  :minutos,
  :nombre,
  :objetivo,
  :proyecto,
  :resultado,
  :fecha,
  :actividad,
  :observaciones,
  :created_at,
  :updated_at,
)
