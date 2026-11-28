-- 03_datos_usuarios.sql · ServiTlax
-- Usuarios de ejemplo: los mismos de assets/data/usuarios.json, con los mismos id.
-- Va antes del 04 porque los viajes usan a estos usuarios (1, 3, 4 y 5 pasajeros; 2 conductor).
-- La contraseña nunca se guarda tal cual: SHA2(texto, 256) guarda su huella SHA-256.

DELETE FROM usuarios;

INSERT INTO usuarios (id, nombre_completo, nombre_corto, usuario, correo, contrasena_hash, rol, calificacion) VALUES
(1, 'Lizeth Nallely López García', 'Nallely', 'nallely', 'nallely@servitlax.mx', SHA2('demo123', 256), 'pasajero', 4.9),
(2, 'Abelardo Ortiz', 'Abelardo', 'abelardo', 'abelardo@servitlax.mx', SHA2('demo456', 256), 'conductor', 4.8),
(3, 'María Cruz Sánchez', 'María', 'maria', 'maria@servitlax.mx', SHA2('demo789', 256), 'pasajero', 4.7),
(4, 'Jorge Ramírez', 'Jorge', 'jorge', 'jorge@servitlax.mx', SHA2('demo000', 256), 'pasajero', 4.9),
(5, 'Rosa Hernández', 'Rosa', 'rosa', 'rosa@servitlax.mx', SHA2('demo111', 256), 'pasajero', 5.0);
