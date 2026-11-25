-- 04_datos_servicios_viajes.sql · ServiTlax
DELETE FROM viajes;
DELETE FROM rutas;
DELETE FROM caracteristicas;
DELETE FROM lugares;
DELETE FROM servicios;

INSERT INTO servicios (id, nombre, descripcion, imagen, capacidad, tarifa_base, precio_km) VALUES
(1, 'Mototaxi', 'Transporte tradicional, económico y rápido para trayectos locales de corta distancia.', 'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=500&q=80', 3, 10.00, 5.00),
(2, 'Moto Rápido', 'Servicio individual ágil para desplazarse evitando el tráfico local.', 'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?w=500&q=80', 1, 12.00, 6.50),
(3, 'Taxi Rápido', 'Vehículo cómodo con cajuela para traslados con mayor equipaje o familias.', 'https://images.unsplash.com/photo-1549317661-bd32c8ce0db2?w=500&q=80', 4, 20.00, 9.00);

INSERT INTO caracteristicas (servicio_id, texto) VALUES
(1, 'Económico'),
(1, 'Ideal para distancias cortas'),
(1, 'Capacidad hasta 3 pasajeros'),
(2, 'Rápido y dinámico'),
(2, 'Casco incluido'),
(2, '1 pasajero'),
(3, 'Cómodo y espacioso'),
(3, 'Espacio para equipaje'),
(3, 'Capacidad hasta 4 pasajeros');

INSERT INTO lugares (id, nombre, descripcion) VALUES
(1, 'Tlaxiaco', 'Centro de Tlaxiaco'),
(2, 'Magdalena', 'Barrio de Magdalena'),
(3, 'Tecnológico de Tlaxiaco', 'Av. Tecnológico'),
(4, 'Hospital San Pedro', 'Urgencias 24 h'),
(5, 'Boquerón', 'Barrio de Boquerón');

INSERT INTO rutas (id, origen_id, destino_id, km, minutos) VALUES
(1, 1, 2, 3.5, 11),
(2, 2, 1, 3.5, 11),
(3, 1, 3, 1.8, 7),
(4, 3, 1, 1.8, 7),
(5, 1, 4, 5.2, 15),
(6, 4, 1, 5.2, 15);

INSERT INTO viajes (id, folio, pasajero_id, conductor_id, servicio_id, origen_id, destino_id, km, minutos, total, estado, fecha_hora) VALUES
(1042, 'VT-1042', 1, NULL, 1, 1, 2, 3.5, 11, 27.50, 'pendiente',  '2026-11-22 09:20:00'),
(1043, 'VT-1043', 3, NULL, 3, 1, 4, 5.2, 15, 66.80, 'pendiente',  '2026-11-22 09:26:00'),
(1044, 'VT-1044', 4, NULL, 2, 1, 3, 1.8,  7, 23.70, 'pendiente',  '2026-11-22 09:31:00'),
(1040, 'VT-1040', 1, 2,    1, 1, 3, 1.8,  7, 19.00, 'aceptado',   '2026-11-22 08:50:00'),
(1038, 'VT-1038', 5, 2,    1, 1, 3, 1.8,  7, 19.00, 'completado', '2026-11-22 08:05:00'),
(1021, 'VT-1021', 1, 2,    3, 1, 3, 1.8,  7, 36.20, 'completado', '2026-11-16 07:40:00'),
(1009, 'VT-1009', 1, 2,    1, 2, 1, 3.5, 11, 27.50, 'completado', '2026-11-13 18:12:00');