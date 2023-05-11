/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR,
date_of_birth DATE,
escape_attempts INT,
neutered BIT,
weight_kg DECIMAL,
PRIMARY KEY(id),
CONSTRAINT fk_species FOREIGN KEY(id) REFERENCES species(id) ON DELETE CASCADE,
CONSTRAINT fk_owner FOREIGN KEY(id) REFERENCES owners(id) ON DELETE CASCADE
);

CREATE TABLE owners(
id INT GENERATED ALWAYS AS IDENTITY,
full_name VARCHAR(50),
age INT,
PRIMARY KEY(id)
);

CREATE TABLE species(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(50),
PRIMARY KEY(id)
);