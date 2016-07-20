# encoding: UTF-8

require 'rails_helper'


RSpec.describe Cor1440Gen::ActividadesController, :type => :controller do
  routes { Cor1440Gen::Engine.routes }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:usuario]
    u = build(:usuario)
    allow(controller).to receive(:current_usuario).and_return(u)
  end

  it "should have a current_user" do
    expect(subject.current_usuario).not_to be_nil
  end
  # Atributos mínimos para crear un usuario válido.
  let(:atributos_validos) {
    { nombre: "nombreact",
    oficina_id: "1",
    fecha: "2014-11-11",
    created_at: "2014-11-11" }
  }

  let(:atributos_invalidos) {
    { nombre: '',
      created_at: '2014-11-11' }
  }

  # Atributos mínimos de valores de sesión para pasar filtros (como 
  # autenticación) definidos en UsuariosController.
  # De http://luisalima.github.io/blog/2013/01/09/how-i-test-part-iv/
  let(:valid_session) { 
    {"warden.user.user.key" => session["warden.user.user.key"]}
  }

  describe "GET index" do
    it "asigna todas los actividades como @actividades" do
      ac = Cor1440Gen::Actividad.create! atributos_validos
      get :index, params: {}, session: valid_session
      expect(assigns(:actividades)).to eq([ac])
      ac.destroy!
    end
  end

  describe "GET show" do
    it "asigna la actividad requerida como @actividad" do
      ac = Cor1440Gen::Actividad.create! atributos_validos
      get :show, params: {:id => ac.to_param}, session: valid_session
      expect(assigns(:actividad)).to eq(ac)
      ac.destroy!
    end
  end

  describe "GET new" do
    it "asigna una nueva actividad como @actividad" do
      get :new, params: {}, session: valid_session
      expect(assigns(:actividad)).to be_a_new(Cor1440Gen::Actividad)
    end
  end

  describe "GET edit" do
    it "asigna la actividad requerida como @actividad" do
      ac = Cor1440Gen::Actividad.create! atributos_validos
      get :edit, params: {:id => ac.to_param}, session: valid_session
      expect(assigns(:actividad)).to eq(ac)
      ac.destroy!
    end
  end

  describe "POST create" do
    describe "con parámetros validos" do
      it "crea una Actividad" do
        expect {
          post :create, params: {:actividad => atributos_validos}, 
            session: valid_session
        }.to change(Cor1440Gen::Actividad, :count).by(1)
      end

      it "asigna la actividad recien creado como @actividad" do
        post :create, params: {:actividad => atributos_validos}, 
          session: valid_session
        expect(assigns(:actividad)).to be_a(Cor1440Gen::Actividad)
        ac = Cor1440Gen::Actividad.where(nombre: 'nombreact').take
        ac.destroy!
      end

      it "redirige al usuario creado" do
      skip
        post :create, params: {:usuario => atributos_validos}, 
          session: valid_session
        #expect(response.status).to eq(200)
        expect(response).to redirect_to(Usuario.last)
        usuario = Usuario.where(nombre: 'nombreact').take
        usuario.destroy!
      end
    end

    describe "con parámetros invalidos" do
      it "assigns a newly created but unsaved usuario as @usuario" do
        skip
        post :create, params: {:usuario => inatributos_validos}, 
          session: valid_session
        expect(assigns(:usuario)).to be_a_new(Usuario)
      end

      it "vuelve a presentar la plantilla 'nueva'" do
        skip
        post :create, params: {:usuario => inatributos_validos}, 
          session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "con parámetros válidos" do
      let(:new_attributes) {
        { minutos: "90", nombre: "nombreact2",
          fecha: "2014-11-18", created_at: "2014-11-18" }
      }

      it "actualiza el usuario requerido" do
        skip
        usuario = Usuario.create! atributos_validos
        put :update, 
          params: {:id => usuario.to_param, :usuario => new_attributes}, 
          session: valid_session
        usuario.reload
        usuario.destroy!
        #expect(usuario.oficina_id).to eq(1)
      end

      it "asigna el usuario requerido como @usuario" do
        skip
        usuario = Usuario.create! atributos_validos
        put :update, 
          params: {:id => usuario.to_param, :usuario => atributos_validos}, 
          session: valid_session
        expect(assigns(:usuario)).to eq(usuario)
        usuario.destroy!
      end

      it "redirige al usuario" do
        skip
        usuario = Usuario.create! atributos_validos
        put :update, 
          params: {:id => usuario.to_param, :usuario => atributos_validos}, 
          session: valid_session
        expect(response).to redirect_to(usuario)
        usuario.destroy!
      end
    end

    describe "con parametros inválidos" do
      it "asinga el usuario como @usuario" do
        skip
        usuario = Usuario.create! atributos_validos
        put :update, 
          params: {:id => usuario.to_param, :usuario => inatributos_validos}, 
          session: valid_session
        expect(assigns(:usuario)).to eq(usuario)
        usuario.destroy!
      end

      it "vuelve a presentar la plantilla 'editar'" do
        skip
        usuario = Usuario.create! atributos_validos
        put :update, 
          params: {:id => usuario.to_param, :usuario => inatributos_validos}, 
          session: valid_session
        expect(response).to render_template("edit")
        usuario.destroy!
      end
    end
  end

  describe "DELETE destroy" do
    it "elimina el usuario requerido" do
        skip
      if Usuario.where(nusuario: 'nusuario').count > 0 
        usuario = Usuario.where(nusuario: 'nusuario').take
      else
        usuario = Usuario.create! atributos_validos
      end
      expect {
        delete :destroy, params: {:id => usuario.to_param}, 
          session: valid_session
      }.to change(Usuario, :count).by(-1)
    end

    it "redirige a la lista de usuarios" do
        skip
      usuario = Usuario.create! atributos_validos
      delete :destroy, params: {:id => usuario.to_param}, 
        session: valid_session
      expect(response).to redirect_to(usuarios_path)
    end
  end

end
