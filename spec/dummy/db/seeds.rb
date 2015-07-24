# encoding: UTF-8

conexion = ActiveRecord::Base.connection();

Sip::carga_semillas_sql(conexion, 'sip', :datos)
Sip::carga_semillas_sql(conexion, '../..', :cambios)
Sip::carga_semillas_sql(conexion, '../..', :datos)

# usuario: cor1440, clave: cor1440
conexion.execute("INSERT INTO usuario 
	(nusuario, email, encrypted_password, password, 
  fechacreacion, created_at, updated_at, rol) 
	VALUES ('cor1440', 'cor1440@localhost', 
	'$2a$10$q0KcAa.H6.3VrXeKTJHa/ue8uT0y7WVKKHlAVor.Nejpz1OAgAQOq',
	'', '2014-08-14', '2014-08-14', '2014-08-14', 1);")

