-- Deliverable 1 table 
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

Create table employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE Dept_emp (
emp_no INT NOT NULL,
dept_no VARCHAR(40) NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);


CREATE TABLE titles (
emp_no INT NOT NULL,
title VARCHAR(40) NOT NULL,
from_date DATE NOT NULL,
to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no, from_date, title)
);

-- Deliverable 1 

Select e.emp_no, e.first_name, e.last_name, ti.title, ti.from_date, ti.to_date
Into retirement_info
From employees e
Inner Join titles as ti 
ON e.emp_no = ti.emp_no
Where (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

Select * FROM retirement_info


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (ret.emp_no) ret.emp_no,
ret.first_name,
ret.last_name,
ret.title

INTO unique_titles
FROM retirement_info as ret
Where to_date = ('9999-01-01')		
ORDER BY emp_no ASC, to_date DESC;

SELECT * FROM unique_titles

-- part 1.3

SELECT COUNT(unit.emp_no), unit.title  
INTO retiring_titles
FROM unique_titles as unit 
GROUP BY title
ORDER BY COUNT(unit.emp_no) DESC;

SELECT * FROM retiring_titles

-- Deliverable 2 
SELECT distinct on (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
de.from_date, de.to_date, ti.title
INTO mentorship_program
From employees as e
Left outer join dept_emp as de
ON e.emp_no = de.emp_no
Left outer join titles as ti 
ON e.emp_no = ti.emp_no
Where (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND de.to_date = '9999-01-01'
ORDER BY e.emp_no;
SELECT * FROM mentorship_program