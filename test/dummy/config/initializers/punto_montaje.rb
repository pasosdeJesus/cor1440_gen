Dummy::Application.config.relative_url_root = ENV.fetch(
  'RUTA_RELATIVA', '/cor1440')
Dummy::Application.config.assets.prefix = ENV.fetch(
  'RUTA_RELATIVA', '/cor1440') + '/assets'

