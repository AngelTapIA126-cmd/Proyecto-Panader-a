-- Base de datos de Panadería Tapia (MySQL 8.0.16 o superior)
-- Uso: mysql -u root -p --default-character-set=utf8mb4 < schema.sql
-- Se puede ejecutar más de una vez: no duplica productos ni modifica los existentes.

SET NAMES utf8mb4;

CREATE DATABASE IF NOT EXISTS panaderia_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE panaderia_db;

CREATE TABLE IF NOT EXISTS productos (
  id          INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  nombre      VARCHAR(100)  NOT NULL,
  descripcion TEXT          NULL,
  precio      DECIMAL(10,2) NOT NULL,
  stock       INT UNSIGNED  NOT NULL DEFAULT 0,
  imagen_url  VARCHAR(500)  NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_productos_nombre (nombre),
  CONSTRAINT chk_productos_precio CHECK (precio >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Nombres, descripciones, precios e imágenes tomados del catálogo de panaderia-tapia.html.
-- Los valores de stock son de ejemplo.
INSERT INTO productos (nombre, descripcion, precio, stock, imagen_url) VALUES
  ('Concha de Vainilla',
   'Suave, esponjosa y con costra de azúcar sabor vainilla, como las de siempre.',
   8.00, 50,
   'https://cdn1.matadornetwork.com/blogs/2/2018/10/conchas-mexicanas-shutterstock_409664776.jpg'),
  ('Concha de Chocolate',
   'Suave, esponjosa y con costra de azúcar sabor chocolate, como las de siempre.',
   8.00, 50,
   'https://cdn1.matadornetwork.com/blogs/2/2018/10/conchas-mexicanas-shutterstock_409664776.jpg'),
  ('Pan de Huevo',
   'Dorado, tierno y con ese aroma inconfundible. El compañero ideal del café campechano.',
   10.00, 40,
   'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?w=500&q=80&auto=format&fit=crop'),
  ('Repostería Regional',
   'Polvorones, marquesitas y dulces de coco con los sabores auténticos del sureste mexicano.',
   15.00, 30,
   'https://images.unsplash.com/photo-1571115177098-24ec42ed204d?w=500&q=80&auto=format&fit=crop'),
  ('Rosca de Reyes',
   'Esponjosa, con ate de colores y costra de azúcar. La rosca tradicional para compartir en familia el Día de Reyes.',
   250.00, 10,
   'imagenes/rosca-de-reyes.png')
ON DUPLICATE KEY UPDATE id = id;
