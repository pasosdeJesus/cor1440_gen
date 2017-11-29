Cor1440Gen::Engine.routes.draw do

  resources :actividades, path_names: { new: 'nueva', edit: 'edita' }
  resources :informes, path_names: { new: 'nuevo', edit: 'edita' }
  resources :proyectosfinancieros, path_names: { new: 'nuevo', edit: 'edita' }

  get "/informes/:id/impreso" => "informes#impreso", 
    as: :impresion

  get "/actividadespf/" => "cor1440_gen/proyectosfinancieros#actividadespf", 
    as: :actividadespf

  resources :objetivospf, only: [:new, :destroy]
  resources :resultadospf, only: [:new, :destroy]
  resources :indicadorespf, only: [:new, :destroy]
  resources :actividadespf, only: [:new, :destroy]

  namespace :admin do
    ab = ::Ability.new
    ab.tablasbasicas.each do |t|
      if (t[0] == "Cor1440Gen") 
        c = t[1].pluralize
        resources c.to_sym, 
          path_names: { new: 'nueva', edit: 'edita' }
      end
    end
  end

end
