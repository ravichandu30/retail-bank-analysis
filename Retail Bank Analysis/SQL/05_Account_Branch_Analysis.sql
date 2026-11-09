-- ============================================================
-- RETAIL BANK ANALYSIS | 05_Account_Branch_Analysis.sql
-- MySQL 8.x
-- ============================================================
USE retail_bank;

-- Account type portfolio
SELECT account_type, COUNT(*) AS accounts,
       ROUND(AVG(current_balance),2) AS avg_balance,
       ROUND(SUM(current_balance),2) AS total_balance
FROM accounts
GROUP BY account_type
ORDER BY total_balance DESC;

-- Actual result snapshot from uploaded data:
--           account_type  accounts  avg_balance  total_balance
--                    IRA       136     21279.47     2894008.04
-- Certificate of Deposit       118     22056.62     2602681.62
--      Business Checking       116     17779.00     2062364.07
--           Money Market       110     15043.19     1654750.54
--                Savings       117      4924.70      576190.25
--               Checking       103      3963.92      408283.79

-- Active vs closed accounts
SELECT status, COUNT(*) AS accounts,
       ROUND(SUM(current_balance),2) AS total_balance
FROM accounts
GROUP BY status;

-- Actual result snapshot from uploaded data:
-- status  accounts  total_balance
-- Active       497    10198278.31
-- Closed       203           0.00

-- Branch activity and balances
SELECT b.branch_id,b.branch_name,b.region,
       COUNT(a.account_id) AS accounts,
       ROUND(SUM(a.current_balance),2) AS total_balance
FROM branches b
LEFT JOIN accounts a ON b.branch_id=a.branch_id
GROUP BY b.branch_id,b.branch_name,b.region
ORDER BY total_balance DESC;

-- Actual result snapshot from uploaded data:
-- branch_id        branch_name  region  accounts  total_balance
--     BR025     Atlanta Branch   South        18      501926.47
--     BR004   San Diego Branch    West        27      438115.39
--     BR023  Washington Branch    East        22      391603.91
--     BR040  Washington Branch    East        19      367333.70
--     BR027    Stockton Branch    West        20      361054.22
--     BR037      Denver Branch Central        20      356445.71
--     BR034   Baltimore Branch    East        21      353678.52
--     BR014    San Jose Branch    West        16      351880.02
--     BR032      Austin Branch   South        20      343026.27
--     BR030 New Orleans Branch   South        21      334839.51

-- Account activity by branch and account type
SELECT b.region,a.account_type,
       COUNT(a.account_id) AS accounts,
       ROUND(AVG(a.current_balance),2) AS avg_balance
FROM accounts a
JOIN branches b ON a.branch_id=b.branch_id
GROUP BY b.region,a.account_type
ORDER BY b.region, accounts DESC;

-- Actual result snapshot from uploaded data:
--  region           account_type  accounts  avg_balance
-- Central                Savings        19      6207.26
-- Central Certificate of Deposit        18     14172.46
-- Central      Business Checking        15     26372.16
-- Central               Checking        13      3887.63
-- Central                    IRA        12      7498.36
-- Central           Money Market        10     11750.09
--    East                    IRA        32     23060.42
--    East      Business Checking        30     17585.31
--    East           Money Market        28     15077.29
--    East               Checking        28      4604.89

-- Average interest rate by account type
SELECT account_type, COUNT(*) AS accounts,
       ROUND(AVG(interest_rate),2) AS avg_interest_rate
FROM accounts
GROUP BY account_type
ORDER BY avg_interest_rate DESC;

-- Actual result snapshot from uploaded data:
--           account_type  accounts  avg_interest_rate
-- Certificate of Deposit       118               4.62
--                    IRA       136               3.78
--           Money Market       110               3.27
--                Savings       117               2.61
--      Business Checking       116               0.51
--               Checking       103               0.24

