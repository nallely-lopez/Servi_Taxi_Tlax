-- 01_usuarios.sql · ServiTlax
-- Tabla de usuarios (pasajeros y conductores).
-- Va primero porque viajes (archivo 02) la referencia con llaves foráneas.

-- Permite borrarla aunque viajes ya exista (si no, MySQL lo impide: error 3730).
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS usuarios;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre_completo VARCHAR(120) NOT NULL,
  nombre_corto VARCHAR(40) NOT NULL,
  usuario VARCHAR(40) NOT NULL UNIQUE,
  correo VARCHAR(120) NOT NULL UNIQUE,
  contrasena_hash VARCHAR(255) NOT NULL,
  rol ENUM('pasajero','conductor') NOT NULL DEFAULT 'pasajero',
  calificacion DECIMAL(2,1) NOT NULL DEFAULT 5.0,
  creado_en DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
