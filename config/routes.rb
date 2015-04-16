Cor1440Gen::Engine.routes.draw do

  get '/anexoactividades/descarga_anexoactividad/:id' => 
    'anexoactividades#descarga_anexoactividad'

  resources :actividades, path_names: { new: 'nueva', edit: 'edita' }

  devise_scope :usuario do
    get 'sign_out' => 'devise/sessions#destroy'
  end
  devise_for :usuarios, :skip => [:registrations], module: :devise
  as :usuario do
    get 'usuarios/edit' => 'devise/registrations#edit', 
      :as => 'editar_registro_usuario'    
    put 'usuarios/:id' => 'devise/registrations#update', 
      :as => 'registro_usuario'            
  end
  resources :usuarios, path_names: { new: 'nuevo', edit: 'edita' } 

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
