# encoding: UTF-8

connection = ActiveRecord::Base.connection();

# Básicas de motor SIVeL genérico
l = File.readlines(
  Gem.loaded_specs['sip'].full_gem_path + "/db/datos-basicas.sql"
)
connection.execute(l.join("\n"))

# Cambios a básicas de SIVel genérico
l = File.readlines("../../db/cambios-basicas.sql")
connection.execute(l.join("\n"))

# Nuevas basicas de motor SIVeL SJR
l = File.readlines("../../db/datos-basicasn.sql")
connection.execute(l.join("\n"));

# Usuario para primer ingreso
connection.execute("INSERT INTO usuario 
	(nusuario, email, encrypted_password, password, 
  fechacreacion, created_at, updated_at, rol) 
	VALUES ('sivel2core', 'sivel2core@localhost', 
	'$2a$10$uMAciEcJuUXDnpelfSH6He7BxW0yBeq6VMemlWc5xEl6NZRDYVA3G', 
	'', '2014-08-14', '2014-08-14', '2014-08-14', 1);")

