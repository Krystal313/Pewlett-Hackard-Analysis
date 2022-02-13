-- Create a table for retirees with all titles since they were hired
SELECT e.emp_no,
e.first_name,
e.last_name,
t.titles,
t.from_date,
t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

select * from retirement_titles

-- Create a table using Dictinct ON to remove duplicate rows and Order by most recent title of retirees
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.titles
INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = ('9999-01-01')
ORDER BY rt.emp_no,rt.to_date DESC;

select * from unique_titles

-- Create a table with the number of employees by their most recent job title who are about to retire.
SELECT COUNT(ut.emp_no), ut.titles
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.titles
ORDER BY COUNT (ut.emp_no) DESC;

Select * from retiring_titles

-- Create a mentorship eligibility table that hold eligible employees with DOB 01/01/1965 - 12/31/1965.
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.titles
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE de.to_date =('9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

select * from mentorship_eligibility