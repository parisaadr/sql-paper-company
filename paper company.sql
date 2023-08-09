CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_day DATE,
    sex VARCHAR(6),
    salary INT,
    super_id INT,
    branch_id INT
);

CREATE TABLE Branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY (mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE Employee
ADD FOREIGN KEY (branch_id) REFERENCES Branch(branch_id) ON DELETE SET NULL ;

ALTER TABLE Employee
ADD FOREIGN KEY (super_id) REFERENCES Employee(emp_id) ON DELETE SET NULL ;

CREATE TABLE Client (
    client_id INT PRIMARY KEY,
    client_name VARCHAR(40),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE Work_with (
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY (emp_id, client_id),
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id) ON DELETE CASCADE ,
    FOREIGN KEY (client_id) REFERENCES Client(client_id) ON DELETE CASCADE
);

CREATE TABLE Branch_Supplier (
    branch_id INT,
    supplier_name VARCHAR(40),
    supply_type VARCHAR(40),
    PRIMARY KEY (branch_id,supplier_name),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id) ON DELETE CASCADE
);

-- Corporate
INSERT INTO Employee VALUES (100,'David','Wallace','1967-11-17','F',250000,NULL,NULL);
INSERT INTO Branch VALUES (1,'Corporate',100,'2006-02-09');
UPDATE Employee
SET branch_id = 1
WHERE emp_id =100;
UPDATE Employee
SET sex='M'
WHERE first_name='David';

INSERT INTO Employee VALUES(101,'Jan','Levinson','1961-05-11','F',110000,100,1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- Branch Supplier
INSERT INTO branch_supplier VALUES (2,'Hammer Mill','paper');
INSERT INTO branch_supplier VALUES (2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES (3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES (2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES (3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES (3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES (3, 'Stamford Lables', 'Custom Forms');

-- Client
INSERT INTO client VALUES (400,'Dunmore Highschool',2);
INSERT INTO client VALUES (401,'Lackawana Country',2);
INSERT INTO client VALUES (402,'FedEx',3);
INSERT INTO client VALUES (403,'John Daly Law, LLC',3);
INSERT INTO client VALUES (404,'Scranton Whitepages',2);
INSERT INTO client VALUES (405,'Times Newspaper',3);
INSERT INTO client VALUES (406,'FedEx',2);

-- Works with
INSERT INTO Work_with VALUES (105,400,55000);
INSERT INTO Work_with VALUES (102,401,267000);
INSERT INTO Work_with VALUES (108,402,22500);
INSERT INTO Work_with VALUES (107,403,5000);
INSERT INTO Work_with VALUES (108,403,12000);
INSERT INTO Work_with VALUES (105,404,33000);
INSERT INTO Work_with VALUES (107,405,26000);
INSERT INTO Work_with VALUES (102,406,15000);
INSERT INTO Work_with VALUES (105,406,130000);

SELECT * FROM Employee;
SELECT * FROM Branch;
SELECT * FROM Client;
SELECT * FROM Work_with;
SELECT * FROM branch_supplier;

SELECT *
FROM Employee
ORDER BY salary DESC;

SELECT *
FROM Employee
ORDER BY sex,first_name,last_name;

SELECT *
FROM Employee
LIMIT 5;

SELECT first_name, last_name
FROM Employee;

SELECT first_name AS forename, last_name AS surname
FROM Employee;

SELECT DISTINCT sex
FROM Employee;

SELECT DISTINCT client_name AS Client
FROM Client;

SELECT COUNT(emp_id)
FROM Employee;

SELECT COUNT(emp_id)
FROM Employee
WHERE sex = 'F' AND birth_day > '1970-01-10';

SELECT *
FROM Employee
WHERE sex = 'F' AND birth_day > '1970-01-10';

SELECT AVG(salary)
FROM Employee;

SELECT last_name, salary
FROM Employee
WHERE salary > (SELECT AVG(salary)
   FROM Employee);

SELECT SUM(salary)
FROM Employee;

SELECT COUNT(sex),sex
FROM Employee
GROUP BY sex;

SELECT SUM(total_sales) AS Income ,last_name AS salesperson
FROM Work_with, employee
GROUP BY last_name
ORDER BY last_name;

SELECT *
FROM Client
WHERE client_name LIKE '%EX';

SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '%LABEL%';

SELECT *
FROM Employee
WHERE birth_day LIKE '____-11%';

SELECT *
FROM Client
WHERE client_name LIKE '%SCHOOL%';

SELECT *
FROM Employee
WHERE last_name LIKE '%W%';

SELECT *
FROM Employee
WHERE last_name LIKE '____ON';

SELECT first_name AS List
FROM Employee
UNION
SELECT branch_name
FROM Branch
UNION
SELECT client_name
FROM Client;

SELECT client_name AS List, branch_id
FROM Client
UNION
SELECT supplier_name, branch_id
FROM branch_supplier
ORDER BY branch_id;

SELECT salary AS NET, emp_id
FROM Employee
UNION
SELECT total_sales, emp_id
FROM Work_with
ORDER BY emp_id;

SELECT * FROM Branch;

INSERT INTO Branch VALUES (4, 'Buffalo', NULL,NULL);

SELECT Employee.emp_id, Employee.first_name, Branch.branch_name
FROM Employee
JOIN Branch
ON Employee.emp_id = Branch.mgr_id;

SELECT Employee.emp_id, last_name, total_sales
FROM Employee
JOIN Work_with
ON Employee.emp_id = Work_with.emp_id;

SELECT emp_id, last_name
FROM Employee
UNION
SELECT emp_id, total_sales
FROM Work_with;

SELECT Employee.emp_id, Employee.first_name, Branch.branch_name
FROM Employee
JOIN Branch
ON Employee.emp_id = Branch.mgr_id;

SELECT Employee.emp_id, Employee.first_name, Branch.branch_name
FROM Employee
LEFT JOIN Branch
ON Employee.emp_id = Branch.mgr_id;

SELECT Employee.emp_id, Employee.first_name, Branch.branch_name
FROM Employee
RIGHT JOIN Branch
ON Employee.emp_id = Branch.mgr_id;

SELECT Employee.emp_id, Employee.first_name, Branch.branch_name
FROM Employee
JOIN Branch
ON Employee.emp_id = Branch.mgr_id;

SELECT first_name, last_name, emp_id
FROM Employee
WHERE emp_id IN (SELECT Work_with.emp_id
FROM Work_with
WHERE Work_with.total_sales > 30000
    );

SELECT Work_with.emp_id
FROM Work_with
WHERE Work_with.total_sales > 30000;

SELECT branch_id
FROM Branch
WHERE mgr_id = 102;

SELECT client_name
FROM Client
WHERE branch_id = (SELECT branch_id
FROM Branch
WHERE mgr_id = 102);

CREATE TABLE Branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY (mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

SELECT * FROM Branch;

DELETE FROM Employee WHERE emp_id = 102;

SELECT * FROM Employee;

SELECT * FROM Branch_Supplier;

DELETE FROM Branch WHERE branch_id = 2;

INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');


UPDATE employee
SET branch_id = 2
WHERE emp_id = 105;

UPDATE Employee
SET super_id = 102
WHERE emp_id IN (103,104,105);

UPDATE Employee
SET branch_id = 2
WHERE emp_id IN (102,103,104);

SELECT * FROM Employee;

CREATE TABLE trigger_warn (
    message VARCHAR(100)
);

SELECT * FROM trigger_warn;

DELIMITER $$
CREATE TRIGGER my_trigger BEFORE INSERT ON Employee FOR EACH ROW BEGIN
    INSERT INTO trigger_warn VALUES ('added new employee');
END$$

DELIMITER ;

INSERT INTO Employee VALUES (109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

SELECT * FROM trigger_warn;

DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_warn VALUES(NEW.first_name);
    END$$
DELIMITER ;
INSERT INTO employee
VALUES(110, 'Kevin', 'Malone', '1978-02-19', 'M', 69000, 106, 3);

SELECT * FROM trigger_warn;

DELIMITER $$
CREATE
    TRIGGER mine_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
         IF NEW.sex = 'M' THEN
               INSERT INTO trigger_warn VALUES('added male employee');
         ELSEIF NEW.sex = 'F' THEN
               INSERT INTO trigger_warn VALUES('added female');
         ELSE
               INSERT INTO trigger_warn VALUES('added other employee');
         END IF;
    END$$
DELIMITER ;
INSERT INTO employee
VALUES(111, 'Pam', 'Beesly', '1988-02-19', 'F', 69000, 106, 3);

DELIMITER $$
CREATE
    TRIGGER da_trigger AFTER UPDATE
    ON employee
    FOR EACH ROW BEGIN
         IF NEW.sex = 'M' THEN
               INSERT INTO trigger_warn VALUES('added male employee');
         ELSEIF NEW.sex = 'F' THEN
               INSERT INTO trigger_warn VALUES('added female');
         ELSE
               INSERT INTO trigger_warn VALUES('added other employee');
         END IF;
    END$$
DELIMITER ;

INSERT INTO employee
VALUES(112, 'Creed', 'Bratton', '1925-11-01', 'M',80000, 106, 3);

SELECT * FROM trigger_warn;
SELECT * FROM Employee;



SELECT client_id AS ID , client_name AS CLIENT
FROM Client
UNION
SELECT client_id , total_sales AS TOTAL
FROM Work_with
WHERE total_sales > (SELECT AVG(total_sales)
    FROM Work_with);

SELECT CLIENT.client_id AS ID, Client.client_name AS CLIENT,
      total_sales AS TOTAL
FROM Client
JOIN Work_with
    ON Client.client_id = Work_with.client_id
 WHERE total_sales > (SELECT AVG(total_sales)
    FROM Work_with);


SELECT Employee.emp_id, Employee.first_name, Branch.branch_name
FROM Employee
JOIN Branch
ON Employee.emp_id = Branch.mgr_id;


