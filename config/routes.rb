Cor1440Gen::Engine.routes.draw do

  get '/anexoactividades/descarga_anexoactividad/:id' => 
    'anexoactividades#descarga_anexoactividad'

  resources :actividades, path_names: { new: 'nueva', edit: 'edita' }

  namespace :admin do
    Ability.tablasbasicas.each do |t|
      if (t[0] == "Cor1440Gen") 
        c = t[1].pluralize
        resources c.to_sym, 
          path_names: { new: 'nueva', edit: 'edita' }
      end
    end
  end

end
