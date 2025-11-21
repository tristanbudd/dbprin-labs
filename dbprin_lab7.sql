-- Question #1
CREATE ROLE junior_analyst LOGIN PASSWORD 'AnalystPassword123';
GRANT CONNECT ON DATABASE movie_rental TO junior_analyst;

GRANT SELECT ON TABLE staff TO junior_analyst;

-- Question #2
CREATE ROLE cashier LOGIN PASSWORD 'CashierPassword123';
GRANT CONNECT ON DATABASE movie_rental TO cashier;

GRANT INSERT ON TABLE payment_p2022_01 TO cashier;

INSERT INTO payment_p2022_01(customer_id, staff_id, rental_id, amount, payment_date)
VALUES (1, 1, 1, 5.99, CURRENT_TIMESTAMP);

GRANT USAGE, SELECT ON SEQUENCE payment_p2022_01_payment_id_seq TO cashier;

-- Question #3
GRANT SELECT, INSERT ON TABLE rental TO cashier;
GRANT USAGE, SELECT ON SEQUENCE rental_rental_id_seq TO cashier;

INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (17000, CURRENT_DATE, 1, 1, NULL, 1, CURRENT_TIMESTAMP);

SELECT * FROM rental WHERE rental_id = 17000;

DELETE FROM rental WHERE rental_id = 17000;

GRANT DELETE ON TABLE rental TO cashier;

-- Question #4
CREATE ROLE manager LOGIN PASSWORD 'ManagerPass123';
GRANT CONNECT ON DATABASE movie_rental TO manager;
GRANT UPDATE ON TABLE country TO manager WITH GRANT OPTION;

CREATE ROLE sales LOGIN PASSWORD 'SalesPass123';
GRANT CONNECT ON DATABASE movie_rental TO sales;

GRANT UPDATE ON TABLE country TO sales;
GRANT SELECT ON TABLE country TO sales;

-- Question #5
GRANT SELECT ON customer_view TO sales;

-- Question #6
CREATE ROLE admin LOGIN CREATEROLE PASSWORD 'AdminPass123';

CREATE ROLE val LOGIN PASSWORD 'ValPass123';
GRANT admin TO val;

-- Question #7
CREATE ROLE senior_analyst LOGIN PASSWORD 'SeniorAnalyst123' CREATEDB;
GRANT USAGE, CREATE ON SCHEMA public TO senior_analyst;

CREATE TABLE new_table (
    id SERIAL PRIMARY KEY,
    description TEXT
);


