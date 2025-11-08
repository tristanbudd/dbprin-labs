-- Question #1

-- Before (Annotated)
SELECT
  movie_id AS "Movie ID",
  movie_title AS Movie_Title -- <- Missing a comma here.
  movie_lang AS 'LANGUAGE', -- <- Single quotes should be double quotes for aliasing. (2nd) Also, it should be "language" to match the required output.
  cat_name AS "Category"
FROM
  movie
INNER JOIN
      category LINK movie.movie_id = category.movie_id -- <- "LINK" should be "ON"
WHERE
  movie_title = ALADDIN CALENDAR -- <- 'ALADDIN CALENDAR' should be enclosed in single quotes.

-- After (Fully Fixed)
SELECT
  movie.movie_id AS "Movie ID",
  movie.movie_title AS "movie_title",
  movie.language AS "language",
  category.cat_name AS "Category"
FROM
  movie
INNER JOIN
      category ON movie.movie_id = category.movie_id
WHERE
  movie_title = 'ALADDIN CALENDAR';

-- Question #4
EXPLAIN ANALYZE
SELECT
    movie.title AS "Movie Title"
FROM
    movie
JOIN
    movie_category ON movie.movie_id = movie_category.movie_id
JOIN
    category ON movie_category.category_id = category.category_id
WHERE
    category.name = 'Documentary';

-- Search by ID
EXPLAIN ANALYZE
SELECT
    movie.title AS "Movie Title"
FROM
    movie
JOIN
    movie_category ON movie.movie_id = movie_category.movie_id
JOIN
    category ON movie_category.category_id = category.category_id
WHERE
    category.category_id = 6;

-- Question #5
SELECT
    movie.title AS "Movie Title",
    movie.release_year AS "Release Year"
FROM
    movie
JOIN
    language ON movie.original_language_id = language.language_id
WHERE
    language.name = 'Italian'
ORDER BY
    movie.release_year ASC;

-- Question #6
SELECT
    c.name AS "Category",
    l.name AS "Original Language",
    COUNT(m.movie_id) AS "Number of Movies"
FROM
    movie m
JOIN
    movie_category mc ON m.movie_id = mc.movie_id
JOIN
    category c ON mc.category_id = c.category_id
JOIN
    language l ON m.original_language_id = l.language_id
GROUP BY
    c.name,
    l.name
ORDER BY
    "Category",
    "Original Language";
