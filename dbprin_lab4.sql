-- Question #1
SELECT
    employees.name AS "Employee Name",
    departments.department AS "Department",
    projects.project_name AS "Project"
FROM
    employees
JOIN
    departments ON employees.dept_id = departments.dept_id
JOIN
    projects ON employees.project_id = projects.project_id;

-- Relational Algebra
π employees.name, departments.department, projects.project_name
(
    (employees ⨝ employees.dept_id = departments.dept_id departments)
    ⨝ employees.project_id = projects.project_id projects
)

-- Query Tree
π employees.name, departments.department, projects.project_name
                             │
        ⋈ employees.project_id = projects.project_id
                             │
         ⋈ employees.dept_id = departments.dept_id
                /                           \
            employees                     departments
                                              \
                                            projects

-- Question #2
SELECT
    departments.department AS "Department Name",
    COUNT(employees.emp_id) AS "Number of Employees"
FROM
    departments
LEFT JOIN
    employees ON departments.dept_id = employees.dept_id
GROUP BY
    departments.department;

-- Relational Algebra
γ departments.department; COUNT(employees.emp_id)
(
    departments ⟕ departments.dept_id = employees.dept_id employees
)

-- Query Tree
γ departments.department; COUNT(employees.emp_id)
                     │
    ⟕ departments.dept_id = employees.dept_id
               /             \
         departments       employees

-- Question #3
SELECT
    departments.department AS "Department Name",
    employees.name AS "Employee Name"
FROM
    departments
LEFT JOIN
    employees ON departments.dept_id = employees.dept_id
WHERE
    departments.location IN ('London', 'Manchester')
ORDER BY
    departments.department, employees.name;

-- Relational Algebra
π departments.department, employees.name
(
    σ departments.location ∈ {'London', 'Manchester'}
    (
        departments ⟕ departments.dept_id = employees.dept_id employees
    )
)

-- Query Tree
  π departments.department, employees.name
                    │
σ departments.location ∈ {'London', 'Manchester'}
                    │
   ⟕ departments.dept_id = employees.dept_id
         /                    \
   departments               employees

-- Question #4
SELECT
    orders.order_id AS "Order ID",
    orders.order_date AS "Order Date",
    shippers.shipper_name AS "Shipper",
    COALESCE(customers.customer_name, 'N/A') AS "Customer Name"
FROM
    orders
JOIN
    shippers ON orders.shipper_id = shippers.shipper_id
LEFT JOIN
    customers ON orders.customer_id = customers.customer_id
ORDER BY
    orders.order_id;

-- Relational Algebra
π order_id, order_date, shipper_name, customer_name
(
    (orders ⨝ orders.shipper_id = shippers.shipper_id shippers)
    ⟕ orders.customer_id = customers.customer_id customers
)

-- Query Tree
π order_id, order_date, shipper_name, customer_name
                │
⟕ orders.customer_id = customers.customer_id
                │
⋈ orders.shipper_id = shippers.shipper_id
        /                \
     orders           shippers

-- Question #5
SELECT
    teams.team_name AS "Team",
    venues.venue_name AS "Venue"
FROM
    teams
CROSS JOIN
    venues;

-- Relational Algebra
π team_name, venue_name (teams × venues)

-- Query Tree
π team_name, venue_name
         │
         ×
        / \
    teams  venues

-- Question #6
SELECT
    e.name AS "Employee Name",
    COALESCE(m.name, 'N/A') AS "Managers Name",
    COALESCE(d.department, 'N/A') AS "Managers Department"
FROM
    employees e
LEFT JOIN
    employees m ON m.emp_id = e.manager_id
LEFT JOIN
    departments d ON m.dept_id = d.dept_id;

-- Relational Algebra
π e.name, m.name, d.department
(
    (employees AS e ⟕ e.manager_id = m.emp_id employees AS m)
    ⟕ m.dept_id = d.dept_id departments AS d
)

-- Query Tree
π e.name, m.name, d.department
               │
  ⟕ m.dept_id = d.dept_id
               │
  ⟕ e.manager_id = m.emp_id
               │
           employees e
               \
            employees m
                   \
               departments d

-- Question #7
SELECT
    m.name,
    b.title,
    g.genre_name
FROM
    members m
JOIN
    loans l ON m.member_id = l.member_id
JOIN
    books b ON l.book_id = b.book_id
JOIN
    genres g ON b.genre_id = g.genre_id
WHERE
    g.genre_name = 'Science Fiction';

-- Relational Algebra
π m.name, b.title, g.genre_name (
    σ g.genre_name = 'Science Fiction' (
        ((members ⨝ m.member_id = l.member_id loans)
         ⨝ l.book_id = b.book_id books)
         ⨝ b.genre_id = g.genre_id genres
    )
)

-- Query Tree
    π m.name, b.title, g.genre_name  -- Root (Final Result)
                     │
            σ g.genre_name = 'Science Fiction' -- Node (Filter)
                     │
                ⋈ b.genre_id = g.genre_id -- Join (#3)
                 /                          \
        ⋈ l.book_id = b.book_id       genres -- Join (#2) & Leaf (Base Table)
         /                              \
⋈ m.member_id = l.member_id  books -- Join (#1) & Leaf (Base Table)
     /
  members -- Leaf (Base Table)

-- Question #8
SELECT
    p.name AS product_name,
    ca.category_name,
    cu.cust_name
FROM
    products p
JOIN
    sales s ON p.product_id = s.product_id
JOIN
    categories ca ON p.category_id = ca.category_id
JOIN
    customers cu ON s.customer_id = cu.customer_id
WHERE
    ca.category_name = 'Electronics';

-- Query Tree
             π p.name, ca.category_name, cu.cust_name
                               │
               ⋈ s.customer_id = cu.customer_id
                 /                                   \
      ⋈ p.category_id = ca.category_id    customers
             /                          \
            /              σ ca.category_name = 'Electronics'
⋈ p.product_id = s.product_id                |
     /                \                         categories
 products            sales

-- Question #9
SELECT
    f.flight_no,
    a.airport_name,
    l.airline_name
FROM
    flights f
JOIN
    routes r ON f.route_id = r.route_id
JOIN
    airports a ON r.destination_id = a.airport_id
JOIN
    airlines l ON f.airline_id = l.airline_id
WHERE
    l.airline_name = 'SkyJet';

-- Relational Algebra
π f.flight_no, a.airport_name, l.airline_name (
    σ l.airline_name = 'SkyJet' (
        ((flights ⨝ f.route_id = r.route_id routes)
         ⨝ r.destination_id = a.airport_id airports)
         ⨝ f.airline_id = l.airline_id airlines
    )
)

-- Query Tree
    π f.flight_no, a.airport_name, l.airline_name
                     │
            σ l.airline_name = 'SkyJet'
                     │
            ⋈ f.airline_id = l.airline_id
                 /                           \
    ⋈ r.destination_id = a.airport_id  airlines
       /                                    \
⋈ f.route_id = r.route_id     airports
     /
  flights
   /
routes