// Question #8
SELECT
    artist.artist_name AS "Artist Name"
FROM
    artwork
JOIN
    creates ON artwork.artwork_id = creates.artwork_id
JOIN
    artist ON creates.artist_id = artist.artist_id
WHERE
    artwork.work_title = 'Rainbow';

// Question #9
SELECT
    artwork.work_title AS "Work Title"
FROM
    artist
JOIN
    creates ON artist.artist_id = creates.artist_id
JOIN
    artwork ON creates.artwork_id = artwork.artwork_id
WHERE
    artist.artist_name = 'Lolo';

// Question #10
SELECT
    artist.artist_name AS "Artist Name",
    artwork.work_title AS "Work Title",
    CONCAT('£', artwork.price) AS "Price"
FROM
    artwork
JOIN
    purchase ON artwork.artwork_id = purchase.artwork_id
JOIN
    artist ON purchase.cust_id = artist.artist_id
WHERE
    artwork.price <= 200
ORDER BY
    artwork.price
ASC;