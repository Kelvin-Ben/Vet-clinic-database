SELECT * FROM animals WHERE (name~* '[mon]') is true;
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name from animals WHERE neutered = True AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = True;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >=10.4 AND weight_kg <= 17.3;

ALTER TABLE animals ADD COLUMN species VARCHAR;
BEGIN;
  UPDATE animals SET species = 'unspecified';
BEGIN;
  UPDATE animals SET species = 'digimon' WHERE name like '%mon';
  UPDATE animals SET species = 'pokemon' WHERE species IS NULL OR species = '';
BEGIN;
  DELETE FROM animals;
BEGIN;
  DELETE FROM animals WHERE date_of_birth > '2022-01-01';
  SAVEPOINT SP1;
  UPDATE animals SET weight_kg = weight_kg * -1;
  ROLLBACK TO SP1;
  UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts = 0;
SELECT 
  weight_kg,
  AVG(weight_kg)
  FROM animals GROUP BY weight_kg;
  SELECT 
    neutered,
    MAX(escape_attempts)
    FROM animals
    GROUP BY neutered;
  SELECT 
    weight_kg,
    MIN(weight_kg),MAX(weight_kg) FROM animals 
    GROUP BY weight_kg;
  SELECT date_of_birth,
    AVG(escape_attempts),
    date_of_birth BETWEEN '1990-12-01' AND '2000-12-01'
    FROM animals GROUP BY date_of_birth;