-- Finding Janette Challenge

-- Clue #1
SELECT
    country.country_code AS "Country Code",
    country.country_name AS "Country Name"
FROM
    country
WHERE
    country.region = 'Southern Europe'
ORDER BY
    country.country_population ASC
LIMIT 1;

-- Clue #2
SELECT
    country_language.language AS "Language"
FROM
    country_language
WHERE
    country_language.country_code = 'VAT';

-- Clue #3
SELECT
    country.country_code AS "Country Code",
    country.country_name AS "Country Name"
FROM
    country_language
JOIN
    country ON country_language.country_code = country.country_code
WHERE
    country_language.language = 'Italian'
AND
    country_language.percentage = 100;

-- Clue #4
SELECT
    city.city_name AS "City Name"
FROM
    city
WHERE
    country_code = 'SMR'
AND
    city_name != 'San Marino';

-- Clue #5
SELECT
    city.city_name AS "City Name"
FROM
    country
JOIN
    city ON country.country_code = city.country_code
WHERE
    country.region = 'South America'
AND
    city.city_name LIKE 'Serr%';

-- Clue #6
SELECT
    city.city_name AS "Capital City"
FROM
    city
WHERE
    city.city_id = (
        SELECT country.capital
        FROM country
        WHERE country.country_code = (
            SELECT city.country_code
            FROM city
            WHERE city.city_name = 'Serra'
    )
);

-- Clue #7
SELECT
    city.city_name AS "City Name",
    country.country_name AS "Country Name"
FROM
    city
JOIN
    country ON city.country_code = country.country_code
WHERE
    city.population = 91084;