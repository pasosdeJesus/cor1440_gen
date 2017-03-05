json.array!(@cor1440_gen_proyectosfinancieros) do |cor1440_gen_proyectofinanciero|
  json.extract! cor1440_gen_proyectofinanciero, :id
  json.url cor1440_gen_proyectofinanciero_url(cor1440_gen_proyectofinanciero, format: :json)
end
