INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, True, 10.23),
        ('Gabumon', '2018-11-15', 2, True, 8),
        ('Pikachu', '2021-01-07', 1, False, 15.04),
        ('Davimon', '2017-05-12', 5, True, 11),
        ('Charmander', '2020-02-08', 0, False, -11),
        ('Plantmon', '2021-11-15', 2, True, -5.7),
        ('Squirtle', '1993-04-02', 3, False, -12.13),
        ('Angemon', '2005-06-12', 1, True, -45),
        ('Boarmon', '2005-06-07', 7, True, 20.4),
        ('Blossom', '1998-10-13', 3, True, 17),
        ('Ditto', '2022-05-14', 4, True, 22);

INSERT INTO owners(full_name,age)
VALUES ('Sam Smith', 34),
        ('Jeniffer Orwell', 19),
        ('Bob', 45),
        ('Dean Winchester', 14),
        ('Jodie Whittaker', 38);

INSERT INTO species(name)
VALUES ('Pokemon'),
        ('Digimon');

-- Insert the following data for vets
INSERT INTO vets(id,vets_name,age,date_of_graduation)
VALUES  (1,'William Tatcher', 45, '2000-04-23'), 
        (2,'Maisy Smith', 26, '2019-01-17'),
        (3,'Stephanie Mendez', 64, '1981-05-04'),
        (4,'Jack Harkness', 38, '2008-06-08');

-- Insert the following data for specialties:
INSERT INTO specializations(vets_id,species_id)
VALUES  (1,1),(3,1),(3,2),(4,2);

-- Insert the following data for visits
INSERT INTO visits(vets_id,animals_id,date_of_visit)
VALUES  (1,1,'2020-05-24'),(3,1,'2020-07-22'),(4,2,'2021-02-02'),(2,3,'2020-01-05'),
        (2,3,'2020-03-08'),(2,3,'2020-05-14'),(3,4,'2021-05-04'),(4,5,'2021-02-24'),
        (2,6'2019-12-21'),(1,6,'2020-08-10'),(2,6,'2021-04-07'),
        (3,7,'2019-09-29'),(4,8,'2020-08-03'),(4,8,'2020-11-04'),(2,9,'2019-01-24'),
        (2,9,'2019-05-15'),(2,9,'2020-02-27'),(2,9,'2020-08-03'),(3,10,'2020-05-24'),
        (1,10,'2021-01-11');