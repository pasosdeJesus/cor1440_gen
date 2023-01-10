# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"

require "simplecov"
Zeitwerk::Loader.eager_load_all # buscando que simplecov cubra más

require_relative "dummy/config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

PRUEBA_ACTIVIDADAREA = {
  id: 1000,
  nombre: "Actividarea",
  fechacreacion: "2014-09-09",
  created_at: "2014-09-09",
}

PRUEBA_ACTIVIDAD = {
  nombre: "n",
  fecha: "2017-03-02",
  oficina_id: 1,
  usuario_id: 1,
}

PRUEBA_ACTIVIDADPF = {
  id: 1,
  proyectofinanciero_id: 1,
  nombrecorto: "a",
  titulo: "aa",
  descripcion: "aaa",
  resultadopf_id: 1,
}

PRUEBA_ANEXO = {
  descripcion: "x",
}

PRUEBA_ASISTENCIA = {
  actividad_id: 1,
  persona_id: 1,
}

PRUEBA_DATOINTERMEDIOTI = {
  nombre: "x",
  nombreinterno: "x",
  funcion: "1",
  mindicadorpf_id: 1,
  tipoindicador_id: 2,
}

PRUEBA_EFECTO = {
  id: 1,
  indicadorpf_id: 1,
  fecha: "2023-01-09",
  registradopor_id: 1,
  nombre: "e",
  descripcion: "d",
}

PRUEBA_FINANCIADOR = {
  id: 1000,
  nombre: "Cor1440_gen_financiador",
  fechacreacion: "2015-04-20",
  created_at: "2015-04-20",
}

PRUEBA_FORMULARIO = {
  nombre: "n",
  nombreinterno: "n",
}

PRUEBA_GRUPOPER = {
  id: 1,
  nombre: "grupoper1",
}

PRUEBA_INDICADORPF = {
  id: 1,
  proyectofinanciero_id: 1,
  resultadopf_id: 1,
  numero: "I1",
  indicador: "Exp I1",
}

PRUEBA_INFORME = {
  titulo: "Informe",
  filtrofechaini: "2014-09-09",
  filtrofechafin: "2014-09-09",
  recomendaciones: "Recomendaciones",
  created_at: "2014-09-09",
  updated_at: "2014-09-09",
}

PRUEBA_MINDICADORPF = {
  id: 1,
  proyectofinanciero_id: 1,
  indicadorpf_id: 1,
  formulacion: "x",
  frecuenciaanual: 1,
  meta: 1,
  medircon: 1,
  funcionresultado: "1",
}

PRUEBA_OBJETIVOPF = {
  id: 1,
  proyectofinanciero_id: 1,
  numero: "o",
  objetivo: "o",
}

PRUEBA_ORGSOCIAL = {
  id: 1,
  grupoper_id: 1,
  created_at: "2021-08-27",
  updated_at: "2021-08-27",
}

PRUEBA_PERSONA = {
  nombres: "Nombres",
  apellidos: "Apellidos",
  anionac: 1980,
  mesnac: 2,
  dianac: 2,
  sexo: "M",
  numerodocumento: "1061000000",
}

PRUEBA_PLANTILLAHCM = {
  ruta: "x",
  fuente: "f",
  licencia: "l",
  vista: "v",
  nombremenu: "n",
  filainicial: 1,
}

PRUEBA_PMINDICADORPF = {
  id: 1,
  mindicadorpf_id: 1,
  finicio: "2023-01-01",
  ffin: "2023-12-31",
  restiempo: "R",
  meta: 1,
}

PRUEBA_PROYECTOFINANCIERO = {
  id: 1,
  nombre: "n",
  observaciones: "o",
  fechainicio: "2023-01-01",
  fechacierre: "2063-01-01",
  responsable_id: 1,
  fechacreacion: "2023-01-01",
  compromisos: "c",
  monto: 100,
  titulo: "t",
  poromision: "f",
  fechaformulacion: "2022-12-31",
  fechaaprobacion: "2022-12-31",
  fechaliquidacion: "2022-12-31",
  estado: "E",
  dificultad: "B",
  tipomoneda_id: 1,
  saldoaejecutarp: 100,
  centrocosto: "c",
  tasaej: 1,
  montoej: 0,
  aportepropioej: 0,
  presupuestototalej: 100,
}

PRUEBA_RANGOEDADAC = {
  id: 1000,
  nombre: "Rangoedadac",
  fechacreacion: "2014-09-09",
  created_at: "2014-09-09",
}

PRUEBA_RESPUESTAFOR = {
  fechaini: "2018-12-19",
  fechacambio: "2018-12-19",
}

PRUEBA_RESULTADOPF = {
  id: 1,
  proyectofinanciero_id: 1,
  objetivopf_id: 1,
  numero: "r",
  resultado: "r",
}

PRUEBA_SECTORAPC = {
  id: 1000,
  nombre: "sectorapc",
  observaciones: "sectorapc",
  fechacreacion: "2023-01-10",
  created_at: "2023-01-10",
}

PRUEBA_TIPOMONEDA = {
  id: 1000,
  nombre: "Cor1440_gen_tipomoneda",
  pais_id: 170,
  simbolo: "x",
  codiso4217: "x",
  fechacreacion: "2015-04-20",
  created_at: "2015-04-20",
}

# Usuario para ingresar y hacer pruebas
PRUEBA_USUARIO = {
  nusuario: "admin",
  password: "sjrven123",
  nombre: "admin",
  descripcion: "admin",
  rol: 1,
  idioma: "es_CO",
  email: "usuario1@localhost",
  encrypted_password: "$2a$10$uMAciEcJuUXDnpelfSH6He7BxW0yBeq6VMemlWc5xEl6NZRDYVA3G",
  sign_in_count: 0,
  fechacreacion: "2014-08-05",
  fechadeshabilitacion: nil,
  oficina_id: nil,
}
