-- Question #1
CREATE TABLE language (
    language_id SERIAL PRIMARY KEY,
    language_name VARCHAR(32) NOT NULL
);

CREATE TABLE actor (
    actor_id SERIAL PRIMARY KEY,
    actor_first_name VARCHAR(32) NOT NULL,
    actor_last_name VARCHAR(32) NOT NULL
);

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(32) NOT NULL
);

CREATE TABLE film (
    film_id SERIAL PRIMARY KEY,
    language_id INT NOT NULL,
    original_language_id INT NOT NULL,
    film_name VARCHAR(32) NOT NULL,
    FOREIGN KEY (language_id) REFERENCES language(language_id),
    FOREIGN KEY (original_language_id) REFERENCES language(language_id)
);

CREATE TABLE film_actor (
    film_id INT REFERENCES film(film_id),
    actor_id INT REFERENCES actor(actor_id),
    PRIMARY KEY (film_id, actor_id)
);

CREATE TABLE film_category (
    film_id INT REFERENCES film(film_id),
    category_id INT REFERENCES category(category_id),
    PRIMARY KEY (film_id, category_id)
);

SELECT
    CONCAT_WS(' ', actor.actor_first_name, actor.actor_last_name) AS "Actor Name",
    film.film_name AS "Film Name"
FROM
    actor
JOIN
    film_actor ON actor.actor_id = film_actor.actor_id
JOIN
    film ON film_actor.film_id = film.film_id
JOIN
    language ON film.language_id = language.language_id
WHERE
    language.language_name = 'English';

INSERT INTO language (language_name)
VALUES
('English'),
('French'),
('German');

INSERT INTO actor (actor_first_name, actor_last_name)
VALUES
('John', 'Smith'),
('Eva', 'Smith'),
('Daisy', 'Renton');

INSERT INTO film (film_name, language_id, original_language_id)
VALUES
('Test Film', 1, 1),
('Test Film The 2nd', 2, 1),
('The Final Test', 2, 3);

INSERT INTO film_actor (film_id, actor_id)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 2),
(3, 3);

UPDATE actor
SET actor_first_name = 'Johnathan'
WHERE actor_id = 1;

UPDATE film
SET film_name = 'Test Film Revised'
WHERE film_id = 1;

UPDATE language
SET language_name = 'Spanish'
WHERE language_id = 3;

DELETE FROM film_actor
WHERE actor_id = 2;

DELETE FROM actor
WHERE actor_id = 2;