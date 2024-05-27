
--Exploratory data analysis 

SELECT * 
FROM FraudDetection.dbo.fraudTest2;

-- 1. Total number of transactions between 21st June, 2020 to 20th December, 2020

SELECT COUNT(is_fraud) AS total_transactions
FROM FraudDetection.dbo.fraudTest2
WHERE trans_date2 BETWEEN '2020-06-21' AND '2020-12-20';

--2. Total number of fraudulent transaction between 21st June, 2020 to 20th December, 2020

SELECT COUNT(*) AS total_fraudulent_transactions
FROM FraudDetection.dbo.fraudTest2
WHERE is_fraud = 1
  AND trans_date2 BETWEEN '2020-06-21' AND '2020-12-20';

--3. Total number of clean transaction between 21st June, 2020 to 20th December, 2020

SELECT COUNT(*) AS total_clean_transactions
FROM FraudDetection.dbo.fraudTest2
WHERE is_fraud = 0
  AND trans_date2 BETWEEN '2020-06-21' AND '2020-12-20';

--4. Checking for fraudulent transactions by category

SELECT category, COUNT(*) AS fraud_count
FROM FraudDetection.dbo.fraudTest2
WHERE is_fraud = 1
GROUP BY category
ORDER BY fraud_count DESC; 
 
--5. Total amount by fraudulent and non-fraudulent transactions

SELECT is_fraud, 
	SUM(amt) AS total_amount
FROM FraudDetection.dbo.fraudTest2
GROUP BY is_fraud;

--6. Average Transaction Amount by Category

SELECT category,
	AVG(amt) AS avg_amount
FROM FraudDetection.dbo.fraudTest2
GROUP BY category
ORDER BY avg_amount DESC;

--7. Most common merchant for fraudulent transactions

SELECT TOP 10 merchant, COUNT(*) AS fraud_count
FROM FraudDetection.dbo.fraudTest2
WHERE is_fraud = 1
GROUP BY merchant
ORDER BY fraud_count DESC;

--8. Number of transactions by state

SELECT state, COUNT(*) AS transaction_count
FROM FraudDetection.dbo.fraudTest2
GROUP BY state
ORDER BY transaction_count DESC;

--9. Checking the rate of fraudulent transactions by state

SELECT state, 
    COUNT(*) AS total_transactions, 
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS fraudulent_transactions,
    (SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS fraud_rate
FROM FraudDetection.dbo.fraudTest2
GROUP BY state
ORDER BY fraud_rate DESC;

--10. Number of transactions by gender

SELECT gender, 
	COUNT(*) AS transaction_count
FROM FraudDetection.dbo.fraudTest2
GROUP BY gender;

--11. Average transaction amount by gender

SELECT gender, avg(amt) as avg_trans_amount
FROM FraudDetection.dbo.fraudTest2
GROUP BY gender;

--12. Fraudulent transactions by city

SELECT TOP 10 city, COUNT(*) AS fraud_count
FROM FraudDetection.dbo.fraudTest2
WHERE is_fraud = 1
GROUP BY city
ORDER BY fraud_count DESC

--13. Transaction distribution over time

SELECT trans_date2, COUNT(*) AS transaction_count
FROM FraudDetection.dbo.fraudTest2
GROUP BY trans_date2
ORDER BY trans_date2;

--14. Fradulent transaction distribution over time

SELECT trans_date2, COUNT(*) AS fraud_count
FROM FraudDetection.dbo.fraudTest2
WHERE is_fraud = 1
GROUP BY trans_date2
ORDER BY trans_date2;

--15. Fradulent transaction distribution over time (by month)

SELECT 
    FORMAT(trans_date2, 'yyyy-MM') AS month_year, 
    COUNT(*) AS fraud_count
FROM FraudDetection.dbo.fraudTest2
WHERE is_fraud = 1
GROUP BY FORMAT(trans_date2, 'yyyy-MM')
ORDER BY FORMAT(trans_date2, 'yyyy-MM');

--16. Age of customers involved in fraudulent transactions

SELECT 
    DATEDIFF(YEAR, dob2, GETDATE()) AS age, 
    COUNT(*) AS fraud_count
FROM FraudDetection.dbo.fraudTest2
WHERE is_fraud = 1
GROUP BY DATEDIFF(YEAR, dob2, GETDATE())
ORDER BY fraud_count DESC;




