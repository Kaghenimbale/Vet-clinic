/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals
WHERE name LIKE '%___mon';

SELECT name FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals
WHERE neutered='0' AND escape_attempts < 3;

SELECT date_of_birth FROM animals
WHERE name='Agumon' OR name='Pikachu';

SELECT name, escape_attempts FROM animals
vet_clinic-# WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = '1';

SELECT * FROM animals WHERE name = 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- TRANSACTIONS

BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%___mon';


UPDATE animals
SET species = 'pokemon'
WHERE species = '';
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;


BEGIN;
DELETE FROM animals
WHERE date_of_birth > 'Jan 1, 2022';

SAVEPOINT SVP1;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK;

BEGIN;
vet_clinic=*# UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

-- queries

SELECT COUNT(*) FROM animals;

SELECT COUNT(escape_attempts) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT SUM(escape_attempts) FROM animals
GROUP BY neutered;

SELECT MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;

SELECT AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' and '2000-12-31'
GROUP BY species;

SELECT A.id, name, full_name FROM animals A
INNER JOIN owners
ON A.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT A.id, A.name FROM animals A
INNER JOIN species
ON A.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT O.id, full_name, name FROM owners O
LEFT JOIN animals
ON O.id = animals.owner_id;

SELECT S.name, COUNT(*) AS "ANIMALS IN SPECIES"
FROM animals
JOIN species S
ON animals.species_id = S.id
GROUP BY S.name;

SELECT A.id, full_name, A.name AS "DIGIMON OWNED BY Jennifer Orwell"
FROM owners O
JOIN animals A
ON O.id = A.owner_id
JOIN species
ON A.species_id = species.id
WHERE O.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT A.id, A.name AS "ANIMALS WHO NEVER TRIED ESCAPE", full_name, escape_attempts
FROM animals A
JOIN owners
ON A.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

SELECT full_name, COUNT(A.name) AS "NUMBER OF ANIMALS OWNED"
FROM animals A
JOIN owners
ON A.owner_id = owners.id
GROUP BY full_name
ORDER BY "NUMBER OF ANIMALS OWNED" DESC LIMIT 1;

-- Visists 

SELECT A.name, vets.name, V.visit_date
FROM visits V
JOIN animals A
ON V.animal_id = A.id
JOIN vets
ON V.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY V.visit_date DESC LIMIT 1;


SELECT V.name, COUNT(vet_id) AS "NUMBER OF COUNT"
FROM visits
JOIN animals
ON visits.animal_id = animals.id
JOIN vets V
ON visits.vet_id = V.id
WHERE V.name = 'Stephanie Mendez'
GROUP BY V.name;

SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON specializations.species_id = species.id;

SELECT vets.name, animals.name, visits.visit_date
FROM animals
JOIN visits
ON visits.animal_id = animals.id
JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND visits.visit_date BETWEEN 'April 1, 2020' AND 'August 30, 2020';

SELECT animals.name, COUNT(visits.animal_id) AS VISITS
FROM animals
JOIN visits
ON animals.id = visits.animal_id
GROUP BY animals.id
ORDER BY VISITS DESC LIMIT 1;

SELECT A.name, vets.name, V.visit_date
FROM visits V
JOIN animals A
ON V.animal_id = A.id
JOIN vets
ON V.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'

SELECT animals.* AS ANIMAL_INFORMATION, vets.* AS VET_INFORMATION, visits.date
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON visits.vet_id = vets.id
ORDER BY visits.date DESC LIMIT 1;

SELECT COUNT(*) AS "VISITS TO VETS NOT SPECIALISED IN THAT SPECIES"
FROM visits
JOIN vets
ON visits.vet_id = vets.id
JOIN animals
ON visits.animal_id = animals.id
LEFT JOIN specializations
ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id
WHERE specializations.species_id IS NULL;

SELECT MAX(species.name) AS "SPECIES MAISY SMITH SHOULD CONSIDER"
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN species
ON animals.species_id = species.id
WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
GROUP BY species.id ORDER BY COUNT(*) DESC LIMIT 1;
