CREATE DATABASE vet_clinic;
USE vet_clinic;

CREATE TABLE animals (
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL,
    species VARCHAR(255)
);

CREATE TABLE owners(
    id INT GENERATED BY DEFAULT AS IDENTITY,
    full_name VARCHAR(255) NOT NULL,
    age INT,
    PRIMARY KEY(id)
)
CREATE TABLE species(
    id INT GENERATED BY DEFAULT AS IDENTITY,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
)

ALTER TABLE animals 
    ADD CONSTRAINT animals_pk PRIMARY KEY (id);

ALTER TABLE animals
    DROP COLUMN species

ALTER TABLE animals
    ADD COLUMN species_id INT;
ALTER TABLE animals
    Add CONSTRAINT fk_species
    FOREIGN KEY (species_id)
    REFERENCES species (id);
ALTER TABLE animals
    ADD COLUMN owners_id INT;
ALTER TABLE animals
    ADD CONSTRAINT fk_owners
    FOREIGN KEY (owners_id)
    REFERENCES owners (id);

    -- Vet clinic database: add "join table" for visits
CREATE TABLE vets (
    id INT,
    vets_name VARCHAR(255) NOT NULL,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    vets_id INT,
    species_id INT DEFAULT 0,
    PRIMARY KEY (vets_id, species_id),
    CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id),
    CONSTRAINT fk_vets FOREIGN KEY (vets_id) REFERENCES vets(id)
);

CREATE TABLE visits (
    vets_id INT DEFAULT 0,
    animals_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_vets FOREIGN KEY (vets_id) REFERENCES vets(id),
    CONSTRAINT fk_animals FOREIGN KEY (animals_id) REFERENCES animals(id)
);