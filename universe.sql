-- Conectarse a la base
\c universe

-- Eliminar tablas si existen
DROP TABLE IF EXISTS moon CASCADE;
DROP TABLE IF EXISTS planet CASCADE;
DROP TABLE IF EXISTS star CASCADE;
DROP TABLE IF EXISTS galaxy CASCADE;
DROP TABLE IF EXISTS comet CASCADE;

-- Crear Galaxy
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    type TEXT NOT NULL,
    distance_from_earth NUMERIC NOT NULL,
    has_black_hole BOOLEAN NOT NULL
);

-- Crear Star con FK a Galaxy
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id),
    mass NUMERIC NOT NULL,
    is_supernova BOOLEAN NOT NULL
);

-- Crear Planet con FK a Star
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    star_id INT NOT NULL REFERENCES star(star_id),
    population BIGINT NOT NULL,
    has_life BOOLEAN NOT NULL
);

-- Crear Moon con FK a Planet
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    planet_id INT NOT NULL REFERENCES planet(planet_id),
    radius INT NOT NULL,
    is_habitable BOOLEAN NOT NULL
);

-- Quinta tabla extra: Comet
CREATE TABLE comet (
    comet_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    speed INT NOT NULL,
    composition TEXT NOT NULL,
    is_visible BOOLEAN NOT NULL
);

-- Insertar Galaxies (6 filas)
INSERT INTO galaxy (name, type, distance_from_earth, has_black_hole)
VALUES
('Milky Way','Spiral',0,true),
('Andromeda','Spiral',2537000,false),
('Sombrero','Elliptical',29000000,true),
('Whirlpool','Spiral',23000000,false),
('Triangulum','Spiral',3000000,false),
('Messier 87','Elliptical',53000000,true);

-- Insertar Stars (6 filas, ligadas a galaxy_id=1)
INSERT INTO star (name, galaxy_id, mass, is_supernova)
VALUES
('Sun',1,1.0,false),
('Proxima Centauri',1,0.12,false),
('Sirius',1,2.1,false),
('Betelgeuse',1,20.0,true),
('Rigel',1,21.0,true),
('Vega',1,2.2,false);

-- Insertar Planets (12 filas, ligados a star_id=1,2,3)
INSERT INTO planet (name, star_id, population, has_life)
VALUES
('Earth',1,8000000000,true),
('Mars',1,0,false),
('Venus',1,0,false),
('Mercury',1,0,false),
('Jupiter',1,0,false),
('Saturn',1,0,false),
('Uranus',1,0,false),
('Neptune',1,0,false),
('Kepler-22b',2,0,false),
('Gliese 581g',2,0,false),
('HD 209458 b',3,0,false),
('TRAPPIST-1d',2,0,true);

-- Insertar Moons (20 filas, ligados a planet_id válidos)
INSERT INTO moon (name, planet_id, radius, is_habitable)
VALUES
('Moon',1,1737,false),
('Phobos',2,11,false),
('Deimos',2,6,false),
('Io',5,1821,false),
('Europa',5,1560,true),
('Ganymede',5,2634,false),
('Callisto',5,2410,false),
('Titan',6,2575,true),
('Rhea',6,764,false),
('Iapetus',6,734,false),
('Dione',6,561,false),
('Tethys',6,531,false),
('Enceladus',6,252,true),
('Mimas',6,198,false),
('Ariel',7,579,false),
('Umbriel',7,584,false),
('Titania',7,789,false),
('Oberon',7,761,false),
('Triton',8,1353,false),
('Nereid',8,170,false);

-- Insertar Comets (3 filas)
INSERT INTO comet (name, speed, composition, is_visible)
VALUES
('Halley',70,'Ice and dust',true),
('Hale-Bopp',52,'Ice and rock',true),
('Encke',69,'Carbonaceous',false);
