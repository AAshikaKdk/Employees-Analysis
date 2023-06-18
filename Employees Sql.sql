
#0. Remove the duplicates and use the unique values
select distinct
emp_no, from_date
from
t_dept_emp;

#1.Convert the dates to years
Select
	Year(d.from_date) as calender_year,
	e.gender,
	COUNT(e.emp_no) as num_of_employees
from 
	t_employees e
	join
	t_dept_emp d on d.emp_no=e.emp_no
group by calender_year,e.gender
having calender_year >= 1990
order by calender_year;

#2. Number of Male Mangers compared to Female Mangers n different departments as of 1990
select
	dm.emp_no,
    d.dept_name,
    dm.from_date,
    dm.to_date,
    ee.gender,
    e.calender_year,
	Case
		when year(dm.to_date) >= e.calender_year and year(dm.from_date) <= e.calender_year then 1
		else 0
    End as active
   from
   (Select 
		year(hire_date) as calender_year
    from 
		t_employees
	Group by calender_year) e
     cross join
		t_dept_manager dm
	join
		t_departments d On dm.dept_no = d.dept_no
	join
		t_employees ee on dm.emp_no= ee.emp_no
	Order by dm.emp_no, calender_year;
    
    
    
    #3. Trend of Male and Female Salaries Untill 2002
    Select
		e.gender,
        d.dept_name,
		round(avg (s.salary),2) as salary,
        year(s.from_date)as calender_year
    from
		t_employees e
        Join
        t_salaries s on s.emp_no= e.emp_no
        Join
        t_dept_emp de on de.emp_no= e.emp_no
        join
        t_departments d on d.dept_no= de.dept_no
        
        Group by d.dept_no, e.gender, calender_year
        having calender_year <= 2002
        Order by d.dept_no;
        
#obtain the average male and female salary per department within a certain salary range

drop Procedure if exists filter_salary;

delimiter $$
create procedure filter_salary(in p_min_salary float, in p_max_salary float)
begin
select
	e.gender, d.dept_name, avg(s.salary) as avg_salary
from
	t_employees e
    join
    t_salaries s on s.emp_no = e.emp_no
    join
    t_dept_emp de on de.emp_no = e.emp_no
    join
    t_departments d on d.dept_no = de.dept_no
    where s.salary between p_min_salary and p_max_salary
    group by d.dept_no, e.gender;
    End $$
  
    Call filter_salary(50000,90000);
    
    
    
    
    
    
    
	









   
    
    
        
    
    
    
    
    
	

