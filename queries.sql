SELECT * FROM animals WHERE (name~* '[mon]') is true;
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name from animals WHERE neutered = True AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = True;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >=10.4 AND weight_kg <= 17.3;

/*query and update animals table*/
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

    -- Query multiple tables
   BEGIN;
    UPDATE animals SET species_id = 2 WHERE name like '%mon';
    commit;

    BEGIN;
      UPDATE animals SET species_id = 1 WHERE species_id is NULL;
      COMMIT;
  -- MODIFY YOUR INSERTED ANIMALS TO INCLUDE OWNER INFORMATION(owner_id)
  UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
  -- Sam Smith owns Agumon.
  UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
  -- Jennifer Orwell owns Gabumon and Pikachu.
  UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
  -- Melody Pond owns Charmander, Squirtle, and Blossom.
  UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
  -- Dean Winchester owns Angemon and Boarmon.
  UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

  -- Write queries (using JOIN) to answer the following questions
  SELECT * FROM animals a JOIN owners o
  ON o.id = a.owners_id
  WHERE o.full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
  SELECT * FROM animals a JOIN species s
  ON s.id = a.species_id
  WHERE s.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal
  SELECT full_name As "owners", a.name AS "animals"
  FROM animals a RIGHT JOIN owners o
  ON o.id = a.owners_id;
-- How many animals are there per species?
  SELECT COUNT(a.name) As "Quantity", s.name AS "species"
  FROM animals a JOIN species s
  ON s.id = a.species_id GROUP BY s.name;
  -- List all Digimon owned by Jennifer Orwell.
  SELECT a.name AS "Animals", o.full_name "Owner"
  FROM animals a JOIN species s
  ON s.id = a.species_id
  JOIN owners o ON o.id = a.owners_id
  WHERE o.full_name = 'Jeniffer Orwell' AND s.name = 'Digimon';
  -- List all animals owned by Dean Winchester that haven't tried to escape
  SELECT a.name AS "Animals", o.full_name AS "Owner"
  FROM animals a JOIN owners o ON o.id = a.owners_id
  WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;
  -- Who owns the most animals?
  SELECT o.full_name AS "Owner", COUNT(a.name) AS "Quantity"
  FROM animals a JOIN owners o.id
  GROUP BY o.full_name
  ORDERED BY "Quantity" DESC LIMIT 1;

  
                                -- Vet clinic database: add "join table" for visits
  -- Who was the last animal seen by William Tatcher?
  SELECT a.name AS "Animal",
   vet.vets_name AS "VETS",
    visit.date_of_visit AS "Date of visit"
    FROM animals a JOIN visits visit
      ON visit.animals_id = a.id
    JOIN vets vet
     ON vet.id = visit.vets_id
      WHERE vet.vets_name = 'William Tatcher'
    ORDER BY visit.date_of_visit DESC LIMIT 1;

  -- How many different animals did Stephanie Mendez see?
  SELECT vet.vets_name AS "VETS",
   COUNT(visit.date_of_visit) AS "Number of Dates"
    FROM vets vet JOIN visits visit 
    ON vet.id = visit.vets_id 
    WHERE vet.vets_name = 'Staphanie Mendez'
  GROUP BY vet.vets_name;

  -- List all vets and their specialties, including vets with no specialties.
  SELECT vet.vets_name AS "VETS",
   spec.name AS "Speciality"
    FROM vets vet LEFT JOIN specializations spz
    ON vet.id = spz.vets_id
    LEFT JOIN species spec
    ON spec.id = spz.species_id;
  
  -- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
  SELECT a.name AS "Animal",
   vet.vets_name AS "VETS",
    visit.date_of_visit AS "Date"
    FROM animals a JOIN visits visit 
    ON a.id = visit.animals_id 
    JOIN vets vet
    ON vet.id = visit.vets_id 
    WHERE vet.vets_name = 'stephanie Mendez' AND visit.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

  -- What animal has the most visits to vets?
  SELECT a.name AS "Animals",
   COUNT(visit.animals_id) AS "Number of visits"
    FROM animals a JOIN visits visit 
    ON a.id = visit.animals_id 
    GROUP BY a.name 
    ORDER BY "Number of visits" DESC LIMIT 1;

  -- Who was Maisy Smith's first visit?
  SELECT a.name AS "Animals", 
  visit.date_of_visit AS "Date"
  FROM animals a JOIN visits visit 
  ON a.id = visit.animals_id
  JOIN vets vet 
  ON vet.id = visit.vets_id 
  WHERE vet.vets_name = 'Maisy Smith'
  ORDER BY "Date" ASC LIMIT 1;

  -- Details for most recent visit: animal information, vet information, and date of visit.
  SELECT a.name As "Name of animal", 
  a.date_of_birth AS "Born in", 
  a.escape_attempts AS "Number of escapes", 
  a.neutered AS "Neutered",
  a.weight_kg AS "Weight", 
  vet.vets_name AS "VETS", 
  vet.age AS "Age", vet.date_of_graduation AS "Graduation",
  visit.date_of_visit AS "Visit day"
  FROM animals a JOIN visits visit 
  ON a.id = visist.animals_id 
  JOIN vets vet 
  ON vet.id = visit.vets_id
  ORDER BY "Visit day" DESC LIMIT 1;

  -- How many visits were with a vet that did not specialize in that animal's species?
  SELECT COUNT(visit.animals_id) 
  AS "Number of visits with a vet that did not specialize in that animal"
  FROM animals a 
  JOIN visits visit 
  ON visit.animals_id = a.id 
  JOIN vets vet 
  ON vet.id = visit.vets_id 
  JOIN species s ON s.id = a.species_id
  JOIN specializations spz 
  ON spz.vet_id = vet.id 
  JOIN species spec 
  ON spec.id = spz.species_id
  WHERE s.name <> spec.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
  SELECT vet.vets_name AS "VETS", 
  s.name AS "Type of animal", 
  COUNT(s.name) AS "Quantity"
  FROM vets vet 
  JOIN visits visit 
  ON vet.id = visit.vets_id
  JOIN animals a 
  ON a.id = visit.animals_id 
  JOIN species s 
  ON s.id = a.species_id
  WHERE vet.vets_name = 'Maisy Smith' 
  GROUP BY s.name, vet.vets_name 
  ORDER BY "Quantity" DESC LIMIT 1;

  