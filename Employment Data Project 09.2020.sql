

-- Q1.1: What was the average employment in government in California (in millions) in each year between 2008 and 2016?
-- Round the average employment to two digits after the decimal point. Show the record count for each year (should be 12).

SELECT EXTRACT(YEAR FROM date) y, ROUND(AVG(employment_1000s)/1000,2) AS avg_emp_mm, COUNT(*) as record_count
FROM blse
WHERE state='California' AND industry='Government' AND date BETWEEN '2008-01-01' AND '2016-12-31'
GROUP by y
ORDER by y;



-- Q1.2: Which months after 2016 had the average employment in the ‘Total Private’ sector in California higher than 14.6 million 
-- (after rounding)?
-- Round the average employment to one digit after the decimal point. Order the results by the increasing employment numbers. 
-- Show the record count for each month (should be 3).


SELECT EXTRACT(month FROM date) m, COUNT(*) as record_count, ROUND(AVG(employment_1000s)/1000,1) as employ_mm 
FROM blse
WHERE state='California' AND industry='Total Private' AND date>='2017-01-01'
GROUP by EXTRACT(month FROM date)
HAVING ROUND(AVG(employment_1000s)/1000,1)>14.6
ORDER by employ_mm ASC, m;





-- Q1.3: Which industries employed in Alaska but not in Hawaii in 2010-2019?
-- NOTE: Exclude 'Goods Producing','Service-Providing','Total Private','Government' from consideration

SELECT DISTINCT industry FROM blse 
WHERE state='Alaska' AND industry!='Goods Producing' AND industry!='Service-Providing' AND industry!='Total Private' AND industry!='Government' AND date BETWEEN '2010-01-01' AND '2019-12-31'
EXCEPT -- which industries did AK use that HI did not
SELECT DISTINCT industry FROM blse 
WHERE state='Hawaii' AND industry!='Goods Producing' AND industry!='Service-Providing' AND industry!='Total Private' AND industry!='Government' AND date BETWEEN '2010-01-01' AND '2019-12-31'
ORDER BY industry;
