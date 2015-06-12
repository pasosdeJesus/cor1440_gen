Cor1440Gen::Engine.routes.draw do

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

  root 'cor1440_gen/hogar#index' 
end
