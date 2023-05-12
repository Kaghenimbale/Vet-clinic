/* Populate database with sample data. */

INSERT INTO animals(
name,
date_of_birth,
escape_attempts,
neutered,
weight_kg
)
VALUES ('Charmander', 'Feb 8, 2020', 0, '0', -11), ('Plantmon', 'Nov 15, 2021', 2, '1', -5.7), ('Squirtle', 'Apr 2, 1993', 3, '0', -12.13), ('Angemon', 'Jun 12, 2005', 1, '1', -45), ('Boarmon', 'Jun 7, 2005', 7, '1', 20.4), ('Blossom', 'Oct 13, 1998', 3, '1', 17), ('Ditto', 'May 14, 2022', 4, '1', 22);

INSERT INTO owners(
full_name,
age 
)
VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

INSERT INTO species(
name
)
VALUES ('Pokemon'), ('Digimon');

UPDATE animals
SET species_id = 
CASE
WHEN name LIKE '%__mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
ELSE (SELECT id FROM species WHERE name = 'Pokemon')
END;

UPDATE animals
SET owner_id = 
CASE
WHEN name = 'Agumon' THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHEN name = 'Gabumon' OR name = 'Pikachu' THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
When name = 'Devimon' OR name = 'Plantmon' THEN (SELECT id FROM owners WHERE full_name = 'Bob')
WHEN name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom' THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHEN name = 'Angemon' OR name = 'Boarmon' THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
END;

-- INSERT DATA INT vets TABLE

INSERT INTO vets(
name,
age,
date_of_graduation
)
VALUES ('William Tatcher', 45, '2000-04-23'), ('Maisy Smith', 26, '2019-01-17'), ('Stephanie Mendez', 64, '1981-05-04'), ('Jack Harckness',
 38, '2008-06-08');

 INSERT INTO specializations(
species_id,
vet_id
)
VALUES(
(SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'William Tatcher')),
((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Jack Harckness'));
