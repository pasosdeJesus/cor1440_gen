# enconding: UTF-8

require_relative '../../test_helper'
require_relative '../../models/cor1440_gen/proyectofinanciero_test.rb'

module Cor1440Gen
  class ActoressocialesControllerTest < ActionController::TestCase
    include Engine.routes.url_helpers     
     include Devise::Test::IntegrationHelpers

     setup do
       skip
       @actorsocial = Actorsocial(:one)
     end

     test "should get index" do
       skip
       get :index
       assert_response :success
       assert_not_nil assigns(:actorsocial)
     end

     test "should get new" do
       skip
       get :new
       assert_response :success
     end

     test "should create actorsocial" do
       skip
       assert_difference('Actorsocial.count') do
         post :create, actorsocial: { created_at: @actorsocial.created_at, fechacreacion: @actorsocial.fechacreacion, fechadeshabilitacion: @actorsocial.fechadeshabilitacion, nombre: @actorsocial.nombre, observaciones: @actorsocial.observaciones, updated_at: @actorsocial.updated_at }
       end

       assert_redirected_to actorsocial_path(assigns(:actorsocial))
     end

     test "should show actorsocial" do
       skip
       get :show, id: @actorsocial
       assert_response :success
     end

     test "should get edit" do
       skip
       get :edit, id: @actorsocial
       assert_response :success
     end

     test "should update actorsocial" do
       skip
       patch :update, id: @actorsocial, actorsocial: { created_at: @actorsocial.created_at, fechacreacion: @actorsocial.fechacreacion, fechadeshabilitacion: @actorsocial.fechadeshabilitacion, nombre: @actorsocial.nombre, observaciones: @actorsocial.observaciones, updated_at: @actorsocial.updated_at }
       assert_redirected_to actorsocial_path(assigns(:actorsocial))
     end

     test "should destroy actorsocial" do
       skip
       assert_difference('Actorsocial.count', -1) do
         delete :destroy, id: @actorsocial
       end

       assert_redirected_to actorsociales_path
     end

  end
end
