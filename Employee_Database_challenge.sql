-- Use Dictinct with Orderby to remove duplicate rows
SELECT distinct on(rt.emp_no)  rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles 
FROM retirement_titles as rt
WHERE rt.to_date = '9999-01-01'
order by rt.emp_no asc

-- Getting counts for each title
select count(ut.title) as headcounts,ut.title
into retiring_titles
from unique_titles as ut
group by ut.title
order by count(ut.title) desc

-- Mentorship eligibilty
select distinct on (e.emp_no) de.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_dadte,
	de.to_date,
	ti.title
into mentorship_eligibilty
from employees as e
inner join dept_emp as de
on e.emp_no = de.emp_no
inner join titles as ti
on e.emp_no = ti.emp_no
where e.birth_date between '1965-01-01' and '1965-12-31'
order by e.emp_no asc

-- Count each title for mentorship program
select count(me.emp_no),
me.title
from mentorship_eligibilty as me
group by me.title 
order by count(me.emp_no)

-- Total amount need to replace soon
select sum(rt.headcounts),rt.title
into need_to_replace
from retiring_titles as rt
group by rt.title
order by sum(rt.headcounts) asc