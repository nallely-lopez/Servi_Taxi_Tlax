-- 02_servicios_viajes.sql · ServiTlax
DROP TABLE IF EXISTS viajes;
DROP TABLE IF EXISTS rutas;
DROP TABLE IF EXISTS caracteristicas;
DROP TABLE IF EXISTS lugares;
DROP TABLE IF EXISTS servicios;

CREATE TABLE servicios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(60) NOT NULL,
  descripcion VARCHAR(255),
  capacidad INT NOT NULL,
  tarifa_base DECIMAL(8,2) NOT NULL,
  precio_km DECIMAL(8,2) NOT NULL,
  zona VARCHAR(60),
  imagen VARCHAR(120)
);

CREATE TABLE lugares (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(80) NOT NULL,
  descripcion VARCHAR(120)
);

CREATE TABLE caracteristicas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  servicio_id INT NOT NULL,
  texto VARCHAR(80) NOT NULL,
  FOREIGN KEY (servicio_id) REFERENCES servicios(id)
);

CREATE TABLE rutas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  origen_id INT NOT NULL,
  destino_id INT NOT NULL,
  km DECIMAL(5,1) NOT NULL,
  minutos INT NOT NULL,
  FOREIGN KEY (origen_id) REFERENCES lugares(id),
  FOREIGN KEY (destino_id) REFERENCES lugares(id)
);

CREATE TABLE viajes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  folio VARCHAR(20) NOT NULL UNIQUE,
  pasajero_id INT NOT NULL,
  conductor_id INT NULL,
  servicio_id INT NOT NULL,
  origen_id INT NOT NULL,
  destino_id INT NOT NULL,
  km DECIMAL(5,1) NOT NULL,
  minutos INT NOT NULL,
  total DECIMAL(8,2) NOT NULL,
  estado ENUM('pendiente','aceptado','completado') NOT NULL DEFAULT 'pendiente',
  fecha_hora DATETIME NOT NULL,
  pago VARCHAR(20) DEFAULT 'efectivo',
  FOREIGN KEY (pasajero_id) REFERENCES usuarios(id),
  FOREIGN KEY (conductor_id) REFERENCES usuarios(id),
  FOREIGN KEY (servicio_id) REFERENCES servicios(id),
  FOREIGN KEY (origen_id) REFERENCES lugares(id),
  FOREIGN KEY (destino_id) REFERENCES lugares(id)
);