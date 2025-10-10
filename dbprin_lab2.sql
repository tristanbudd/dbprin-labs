-- Question #7
CREATE TABLE animal_type (
    animal_type_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL UNIQUE,
    scientific_name VARCHAR(150) NOT NULL,
    conservation_Status VARCHAR(50) NOT NULL
);

CREATE TABLE menagerie (
    managerie_id SERIAL PRIMARY KEY,
    common_name VARCHAR(50) NOT NULL,
    date_aquired DATE NOT NULL,
    gender CHAR(1) NOT NULL,
    aquired_from VARCHAR(250) NOT NULL,
    name VARCHAR(50) NOT NULL,
    notes TEXT,
    FOREIGN KEY (common_name) REFERENCES animal_type(common_name)
);

INSERT INTO animal_type (common_name, scientific_name, conservation_status)
VALUES
('Bengal Tiger', 'Panthera tigris tigris', 'Endangered'),
('Arctic Wolf', 'Canis lupus arctos', 'Least Concern');

INSERT INTO menagerie (common_name, date_aquired, gender, aquired_from, name, notes)
VALUES
('Bengal Tiger', '2011-07-14', 'F', 'Dhaka Zoo', 'Ariel', 'Healthy coat at last exam'),
('Bengal Tiger', '2008-09-30', 'M', 'National Zoo', 'Freddy', 'Strong appetite'),
('Arctic Wolf', '2006-06-01', 'M', 'Scotland Zoo', 'Spark', 'Likes to play'),
('Arctic Wolf', '2007-06-12', 'F', 'Southampton National Park', 'Mia', 'Doesn''t like sun'),
('Bengal Tiger', '2007-06-12', 'M', 'National Zoo', 'Leo', 'Very active'),
('Arctic Wolf', '2011-07-14', 'F', 'Scotland Zoo', 'Luna', 'Calm and gentle');

-- Question #8
SELECT
    animal_type.common_name AS "Common Name",
    animal_type.scientific_name AS "Scientific Name",
    menagerie.name AS "Animal Name",
    menagerie.date_aquired AS "Date Acquired"
FROM
    animal_type
JOIN
    menagerie ON animal_type.common_name = menagerie.common_name
WHERE
    animal_type.conservation_status = 'Endangered';