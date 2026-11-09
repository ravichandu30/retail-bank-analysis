-- ============================================================
-- RETAIL BANK ANALYSIS | 04_Customer_Analysis.sql
-- MySQL 8.x
-- ============================================================
USE retail_bank;

-- Customers by segment with income and credit profile
SELECT segment, COUNT(*) AS customers,
       ROUND(AVG(annual_income),2) AS avg_income,
       ROUND(AVG(credit_score),2) AS avg_credit_score
FROM customers
GROUP BY segment
ORDER BY customers DESC;

-- Actual result snapshot from uploaded data:
--  segment  customers  avg_income  avg_credit_score
--  Student        100   158116.81            679.15
-- Business         97   144267.52            683.95
--   Retail         80   140525.70            687.08
--  Premium         76   158667.68            685.12
--   Wealth         74   152389.12            679.89
--   Senior         73   156745.53            684.32

-- Customers by state
SELECT state, COUNT(*) AS customers,
       SUM(CASE WHEN is_active='Yes' THEN 1 ELSE 0 END) AS active_customers
FROM customers
GROUP BY state
ORDER BY customers DESC;

-- Actual result snapshot from uploaded data:
-- state  customers  active_customers
--    CA         92                67
--    TX         58                45
--    AZ         28                21
--    MO         26                19
--    PA         24                19
--    CO         20                16
--    NC         18                13
--    KY         16                10
--    TN         15                12
--    NE         15                12

-- KYC status distribution
SELECT kyc_status, COUNT(*) AS customers
FROM customers
GROUP BY kyc_status
ORDER BY customers DESC;

-- Actual result snapshot from uploaded data:
-- kyc_status  customers
--   Verified        143
--    Partial        129
--    Pending        123
--     Failed        105

-- Customers with more than one account
SELECT c.customer_id, c.first_name, c.last_name, c.segment,
       COUNT(a.account_id) AS account_count
FROM customers c
JOIN accounts a ON c.customer_id=a.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name,c.segment
HAVING COUNT(a.account_id)>1
ORDER BY account_count DESC, c.customer_id;

-- Actual result snapshot from uploaded data:
-- customer_id first_name last_name  segment  account_count
--     C000226       Anna     Jones   Senior              8
--     C000146      Pooja    Garcia Business              6
--     C000297     Brenda      Hall   Retail              5
--     C000325       Liam      Choi  Student              5
--     C000345      Janet     Jones   Wealth              5
--     C000497    Dorothy    Flores Business              5
--     C000001     Steven     Davis   Retail              4
--     C000009   Benjamin       Kim   Retail              4
--     C000024      Rahul    Garcia Business              4
--     C000052        Lei     Green   Senior              4

-- Customer tenure bands
SELECT
CASE
 WHEN TIMESTAMPDIFF(YEAR, customer_since, (SELECT MAX(transaction_date) FROM transactions)) < 3 THEN '0-2 Years'
 WHEN TIMESTAMPDIFF(YEAR, customer_since, (SELECT MAX(transaction_date) FROM transactions)) < 6 THEN '3-5 Years'
 WHEN TIMESTAMPDIFF(YEAR, customer_since, (SELECT MAX(transaction_date) FROM transactions)) < 10 THEN '6-9 Years'
 ELSE '10+ Years'
END AS tenure_band,
COUNT(*) AS customers
FROM customers
GROUP BY tenure_band
ORDER BY customers DESC;

-- Actual result snapshot from uploaded data:
-- tenure_band  customers
--   6-9 Years        155
--   10+ Years        143
--   3-5 Years        103
--   0-2 Years         99

