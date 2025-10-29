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

-- Question #13
SELECT
    o.o_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total
FROM
    orders o
JOIN
    orderitems oi ON o.o_id = oi.o_id
JOIN
    products p ON oi.product_id = p.product_id
JOIN
    customers c ON o.customer_id = c.customer_id
WHERE
    p.category = 'Accessories' AND o.order_date >= DATE '2024-01-01'
GROUP BY
    o.o_id, c.customer_name;

-- Relational Algebra
γ o.o_id, c.customer_name; SUM(oi.quantity * oi.unit_price) (
    (
        ( (σ o.order_date >= DATE '2024-01-01' (orders))
          ⨝ o.o_id = oi.o_id orderitems
        )
        ⨝ oi.product_id = p.product_id (σ p.category = 'Accessories' (products))
    )
    ⨝ o.customer_id = c.customer_id customers
)

-- Query Tree
        π o.o_id, c.customer_name, total
                     │
γ o.o_id, c.customer_name; SUM(oi.quantity * oi.unit_price) -> total
                     │
        ⋈ o.customer_id = c.customer_id
            /                        \
    ⋈ oi.product_id = p.product_id   customers (c)
          /                     \
  ⋈ o.o_id = oi.o_id     (σ p.category = 'Accessories')
     /        \                    \
(σ o.order_date >= DATE '2024-01-01')  orderitems   products (p)
        /           \
  orders (o)      orderitems (oi)

-- Key Changes:
-- - p.category = 'Accessories' pushed to products so only accessory products are joined, not everything.
-- - o.order_date >=  DATE '2024-01-01' also pushed to orders to only join relevant data.

-- Question #14
π d.department_name, p.project_name
              │
     ⟕ e.dept_id = d.dept_id
              │
     ⟕ d.dept_id = p.dept_id
         /                  \
   departments             projects
         \
        employees
-- Correct Approach ^

-- - Using left join ensures all departments are preserved and still display even if there are no matches under projects or employees.
-- - Missing data can just be returned as NULL, or can use COALESCE to display N/A e.t.c
-- - Using RIGHT JOIN in Option C means not starting from the main table of departments, it will likely work most of the time but isn't the best option for satisfying the requirements.

-- If you swapped LEFT and RIGHT joins, it would still return the same result, but it could make the query less readable and risk including unrelated rows if join directions aren’t applied carefully.

-- Question #15
SELECT
    s.name AS "Student Name",
    c.course_name AS "Course Name",
    m.module_name AS "Module Name",
    l.name AS "Lecturer Name"
FROM
    students s
JOIN
    enrolments e ON s.student_id = e.student_id
JOIN
    courses c ON e.course_id = c.course_id
JOIN
    modules m ON c.course_id = m.course_id
JOIN
    lecturers l ON m.lecturer_id = l.lecturer_id
WHERE
    c.course_name = 'Software Engineering';

-- Relational Algebra
π s.name, c.course_name, m.module_name, l.name (
    σ c.course_name = 'Software Engineering'
    (
        ((((students ⨝ s.student_id = e.student_id enrolments)
           ⨝ e.course_id = c.course_id courses)
           ⨝ c.course_id = m.course_id modules)
           ⨝ m.lecturer_id = l.lecturer_id lecturers)
    )
)

-- Query Tree
     π s.name, c.course_name, m.module_name, l.name  -- Root (Final Result)
                          │
        σ c.course_name = 'Software Engineering'  -- Node (Filter)
                          │
            ⋈ m.lecturer_id = l.lecturer_id  -- Join (#4)
                 /                       \
     ⋈ c.course_id = m.course_id         lecturers  -- Join (#3) & Leaf (Base Table)
          /                    \
 ⋈ e.course_id = c.course_id    modules  -- Join (#2) & Leaf (Base Table)
      /                 \
⋈ s.student_id = e.student_id   courses  -- Join (#1) & Leaf (Base Table)
     /
 students  -- Leaf (Base Table)
       \
     enrolments  -- Leaf (Base Table)