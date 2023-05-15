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

INSERT INTO visits(
animal_id,
vet_id,
visit_date
)
VALUES ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-04-24'),
((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-07-22'),
((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harckness'), '2021-02-02'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-01-05'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-08'),
((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-03-14'),
((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-04-04'),
((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-02-24'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-08-10'),
((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-04-07'),
((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-09-29'),
((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-03'),
((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harckness'), '2020-11-04'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-01-24'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-05-15'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-02-27'),
((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-08-03'),
((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-05-24'),
((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-01-11');

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
