--linkdin job

drop  table if exists linkdin;
create table linkdin(
	job_id 	         INT,
	job_title        VARCHAR(100),
	company          VARCHAR(100),
	location         VARCHAR(100),
	employment_type  VARCHAR(100),
    experience_level VARCHAR(100),
	industry         VARCHAR(100),
	skills_required  VARCHAR(200),
	salary_min_usd   INT,
    salary_max_usd   INT,
	remote_allowed   VARCHAR(100),
	posted_date      DATE
);
SELECT * FROM linkdin;

--1 Find the top 10 highest-paying job roles
select job_title,salary_max_usd,salary_min_usd
from linkdin
order by salary_max_usd desc
limit 10;

--2 Which companies offer the highest average salary?
select company, avg(salary_max_usd) as average_salary
from linkdin
group by company
order by average_salary desc;

--3  Find the most in-demand skills based on job postings. 
select skills_required, count(*) as demand_skill
from linkdin
group by skills_required 
order by demand_skill desc
limit 10;

--4Compare average salaries between remote and non-remote jobs.
select remote_allowed, count(remote_allowed) as remote_job
from linkdin
group by remote_allowed
order by remote_job desc;

--5industries with the maximum number of openings. 
select industry, count(*) as opening
from linkdin
group by industry
order by opening desc;

--6Rank companies based on maximum salary offered using window functions
select company,max(salary_max_usd) as maximum_salary,
rank() over (order by max(salary_max_usd)desc) as rank_no
from linkdin
group by company;


--7Find the top 5 locations with the highest number of job postings. 
select location, count(job_title) as job_posting
from linkdin
group by location 
order by job_posting desc
limit 5;


--8Detect duplicate job postings based on company and job title
select company,job_title, count(*) as duplicate_job
from linkdin
group by company,job_title
having count(*)>1;


--9Find monthly trends in job postings using posted_date. 
select extract(month from posted_date) as month,count(*) as job_posting
from linkdin
group by month
order by month;


--10Find the average salary for each experience level in PostgreSQL.
 select experience_level, avg(salary_max_usd) as average_salary
 from linkdin
 group by experience_level
 order by average_salary;

--without decimal numbers
 select experience_level, round(avg(salary_max_usd)) as average_salary
 from linkdin
 group by experience_level
 order by average_salary;