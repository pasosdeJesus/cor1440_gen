conexion = ActiveRecord::Base.connection();

# De motores
motor = ['sip', 'heb412_gen', '../..', nil]
motor.each do |m|
    Sip::carga_semillas_sql(conexion, m, :cambios)
    Sip::carga_semillas_sql(conexion, m, :datos)
end

#cor1440, cor1440
conexion.execute("INSERT INTO public.usuario 
	(id, nusuario, nombre, email, encrypted_password, password, 
  fechacreacion, created_at, updated_at, rol) 
	VALUES (1, 'cor1440', 'cor1440', 'cor1440@localhost', 
	'$2a$10$q0KcAa.H6.3VrXeKTJHa/ue8uT0y7WVKKHlAVor.Nejpz1OAgAQOq',
	'', '2014-08-26', '2014-08-26', '2014-08-26', 1);")

