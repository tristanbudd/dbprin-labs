-- Question #1
UPDATE address SET phone = '02392844444' WHERE address_id = 1;

-- Question #2
EXPLAIN
SELECT
    *
FROM
    address
WHERE
    address.phone = '02392844444';

-- Question #3
CREATE INDEX IF NOT EXISTS address_phone ON address(phone);

-- Question #5
DROP INDEX address_phone;

-- Question #6
DROP VIEW IF EXISTS customer_details;

CREATE VIEW customer_details AS
SELECT
    CONCAT_WS(' ', c.first_name, c.last_name) AS "Customer",
    CONCAT_WS(' | ', c.email, a.phone) AS "Contact Details",
    a.address AS "Customer Address",
    ci.city AS "Customer City",
    ct.country AS "Customer Country"
FROM
    customer c
JOIN
    address a ON c.address_id = a.address_id
JOIN
    city ci ON a.city_id = ci.city_id
JOIN
    country ct ON ci.country_id = ct.country_id
ORDER BY
    country ASC;

-- Question #7
SELECT
    city_id AS "City ID",
    city AS "City"
FROM
    city
WHERE
    country_id = (
        SELECT country_id
        FROM country
        WHERE country = 'United Kingdom'
    );

-- Question #8
SELECT
    city_id AS "City ID",
    city AS "City",
    (SELECT country
     FROM country
     WHERE country_id = city.country_id
    ) AS "Country"
FROM
    city
WHERE
    country_id IN (
        SELECT country_id
        FROM country
        WHERE country IN ('United Kingdom', 'France')
    )
ORDER BY
    "Country",
    "City";

-- Challenge #1
SELECT
    DISTINCT CONCAT_WS(' ', c.first_name, c.last_name) AS "Customer",
    c.email AS "Contact Email"
FROM
    customer c
JOIN
    rental r ON c.customer_id = r.customer_id
JOIN
    inventory i ON r.inventory_id = i.inventory_id
JOIN
    movie_category mc ON i.movie_id = mc.movie_id
JOIN
    category ct ON mc.category_id = ct.category_id
WHERE
    ct.name = 'Action'
ORDER BY
    "Customer";