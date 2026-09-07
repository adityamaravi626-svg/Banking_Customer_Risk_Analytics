CREATE DATABASE banking_analytics;

USE banking_analytics;

SELECT * FROM bank_marketing 
LIMIT 10;

SELECT COUNT(*) AS total_records 
FROM bank_marketing;

DESCRIBE bank_marketing;

SELECT MIN(age) AS minimum_age,MAX(age) AS maximum_age,AVG(age) AS average_age
FROM bank_marketing;

SELECT DISTINCT job
FROM bank_marketing
ORDER BY job;

SELECT job,COUNT(*) AS total_records
FROM bank_marketing
GROUP BY job
ORDER BY total_records DESC;

SELECT y,COUNT(*) AS total_records FROM bank_marketing
GROUP BY y;

SELECT COUNT(*) AS total_records,
SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) AS subscriptions,
ROUND(100*SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END)
/COUNT(*),2) AS subscription_rate
FROM bank_marketing; 

SELECT job, COUNT(*) AS total_records, SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END) AS subscriptions,
ROUND(100*SUM(CASE WHEN y='yes' THEN 1 ELSE 0 END)/COUNT(*),2) AS subscription_rate
FROM bank_marketing
GROUP BY job 
ORDER BY subscription_rate DESC;

SELECT education,COUNT(*) AS total_records,
ROUND(100*SUM(CASE WHEN y= 'yes' THEN 1 ELSE 0 END)
/COUNT(*),2) AS subscription_rate
FROM bank_marketing
GROUP BY education
ORDER BY  subscription_rate DESC; 

SELECT marital,COUNT(*) AS total_records,ROUND(100* SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)/ COUNT(*),
        2) AS subscription_rate
FROM bank_marketing
GROUP BY marital
ORDER BY subscription_rate DESC;

SELECT housing,COUNT(*) AS total_records,
ROUND(100*SUM(CASE WHEN y= 'yes' THEN 1 ELSE 0 END)
/COUNT(*),2) AS subscription_rate
FROM bank_marketing
GROUP BY housing
ORDER BY  subscription_rate DESC; 

SELECT loan,COUNT(*) AStotal_records,
ROUND(100*SUM(CASE WHEN y= 'yes' THEN 1 ELSE 0 END)
/COUNT(*),2) AS subscription_rate
FROM bank_marketing
GROUP BY loan
ORDER BY  subscription_rate DESC; 

SELECT `default`,COUNT(*) AStotal_records,
ROUND(100*SUM(CASE WHEN y= 'yes' THEN 1 ELSE 0 END)
/COUNT(*),2) AS subscription_rate
FROM bank_marketing
GROUP BY `default`
ORDER BY  subscription_rate DESC; 

SELECT campaign,COUNT(*) AS total_records,
ROUND(100*SUM(CASE WHEN y= 'yes' THEN 1 ELSE 0 END)
/COUNT(*),2) AS subscription_rate
FROM bank_marketing
GROUP BY campaign
ORDER BY  subscription_rate DESC; 

SELECT contact ,COUNT(*) AS total_records,
ROUND(100*SUM(CASE WHEN y= 'yes' THEN 1 ELSE 0 END)
/COUNT(*),2) AS subscription_rate
FROM bank_marketing
GROUP BY contact 
ORDER BY  subscription_rate DESC; 

SELECT month ,COUNT(*) AS total_records,
ROUND(100*SUM(CASE WHEN y= 'yes' THEN 1 ELSE 0 END)
/COUNT(*),2) AS subscription_rate
FROM bank_marketing
GROUP BY month
ORDER BY  subscription_rate DESC; 

SELECT previous,COUNT(*) AS total_records,
ROUND(100*SUM(CASE WHEN y= 'yes' THEN 1 ELSE 0 END)
/COUNT(*),2) AS subscription_rate
FROM bank_marketing
GROUP BY previous
ORDER BY previous ;  

SELECT poutcome,COUNT(*) AStotal_records,
ROUND(100*SUM(CASE WHEN y= 'yes' THEN 1 ELSE 0 END)
/COUNT(*),2) AS subscription_rate
FROM bank_marketing
GROUP BY poutcome
ORDER BY  subscription_rate DESC; 

SELECT age,
    CASE
        WHEN age < 30 THEN 'Young'
        WHEN age < 45 THEN 'Middle'
        WHEN age < 60 THEN 'Mature'
        ELSE 'Senior'
    END AS age_group, y
FROM bank_marketing; 

SELECT
    campaign,
    CASE
        WHEN campaign <= 1 THEN 'Low'
        WHEN campaign <= 3 THEN 'Moderate'
        WHEN campaign <= 5 THEN 'High'
        ELSE 'Very High'
    END AS campaign_intensity,
    y
FROM bank_marketing; 


SELECT job, COUNT(*) AS total_records
FROM bank_marketing
GROUP BY job
HAVING COUNT(*)>=1000
ORDER BY total_records DESC;

WITH job_stats AS (
    SELECT
        job,COUNT(*) AS total_records,
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS subscriptions
    FROM bank_marketing
    GROUP BY job
)
SELECT
    job,
    total_records,
    subscriptions,
    ROUND(
        100* subscriptions / total_records,
        2
    ) AS subscription_rate
FROM job_stats
ORDER BY subscription_rate DESC;

SELECT
    job,COUNT(*) AS total_records,ROUND(100 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)
        / COUNT(*),2) AS subscription_rate
FROM bank_marketing
GROUP BY job
HAVING
    100 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)/ COUNT(*)>(
        SELECT
            100 * SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)
            / COUNT(*)
        FROM bank_marketing
    )
ORDER BY subscription_rate DESC; 

WITH job_stats AS (
    SELECT job, COUNT(*) AS total_records,
        SUM(
            CASE WHEN y = 'yes' THEN 1 ELSE 0 END
        ) AS subscriptions
    FROM bank_marketing
    GROUP BY job
)
SELECT
    job,total_records,subscriptions,
ROUND(100 * subscriptions / total_records,2) AS subscription_rate,
    RANK() OVER (
        ORDER BY 100* subscriptions / total_records DESC) AS subscription_rank
FROM job_stats;

SELECT
    contact,
    CASE
        WHEN campaign <= 1 THEN 'Low'
        WHEN campaign <= 3 THEN 'Moderate'
        WHEN campaign <= 5 THEN 'High'
        ELSE 'Very High'
    END AS campaign_intensity,
    COUNT(*) AS total_records,
    ROUND(
        100* SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)/ COUNT(*),2) AS subscription_rate
FROM bank_marketing
GROUP BY
    contact,
    campaign_intensity
ORDER BY subscription_rate DESC;

SELECT AVG(emp_var_rate) AS avg_employment_rate,
AVG(cons_price_idx) AS avg_consumer_price_index,
AVG(cons_conf_idx) AS avg_euribor,
AVG(nr_employed) AS avg_employment_count
FROM bank_marketing;

SELECT
    y,
    AVG(emp_var_rate) AS avg_emp_var_rate,
    AVG(cons_price_idx) AS avg_cons_price_idx,
    AVG(cons_conf_idx) AS avg_cons_conf_idx,
    AVG(euribor3m) AS avg_euribor3m,
    AVG(nr_employed) AS avg_nr_employed
FROM bank_marketing
GROUP BY y;

SELECT
    contact,
    housing,
    loan,
    COUNT(*) AS total_records,
    SUM(
        CASE WHEN y = 'yes' THEN 1 ELSE 0 END
    ) AS subscriptions,
    ROUND(
        100 *
        SUM(CASE WHEN y = 'yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS subscription_rate,
    ROUND(AVG(age), 2) AS avg_age,
    ROUND(AVG(campaign), 2) AS avg_campaign_contacts
FROM bank_marketing
GROUP BY
    contact,
    housing,
    loan
HAVING COUNT(*) >= 100
ORDER BY subscription_rate DESC; 

