-- ============================================================
-- RETAIL BANK ANALYSIS | 08_Card_Product_Engagement.sql
-- MySQL 8.x
-- ============================================================
USE retail_bank;

-- Card type portfolio
SELECT card_type, COUNT(*) AS cards,
       SUM(CASE WHEN is_active='Yes' THEN 1 ELSE 0 END) AS active_cards,
       ROUND(AVG(credit_limit),2) AS avg_credit_limit,
       ROUND(SUM(outstanding_balance),2) AS outstanding
FROM cards
GROUP BY card_type
ORDER BY cards DESC;

-- Actual result snapshot from uploaded data:
-- card_type  cards  active_cards  avg_credit_limit  outstanding
--     Debit    358            22              0.00         0.00
--    Credit    242            15          24294.58   2457114.58

-- Card network usage
SELECT network, COUNT(*) AS cards,
       SUM(reward_points) AS reward_points,
       ROUND(SUM(outstanding_balance),2) AS outstanding
FROM cards
GROUP BY network
ORDER BY cards DESC;

-- Actual result snapshot from uploaded data:
--          network  cards  reward_points  outstanding
--             Visa    159        4150994    552667.62
--       Mastercard    153        3743430    567304.97
-- American Express    148        3497631    645180.05
--         Discover    140        3374721    691961.94

-- Cards by account type
SELECT a.account_type,c.card_type,
       COUNT(c.card_id) AS cards,
       SUM(CASE WHEN c.is_active='Yes' THEN 1 ELSE 0 END) AS active_cards
FROM cards c
JOIN accounts a ON c.account_id=a.account_id
GROUP BY a.account_type,c.card_type
ORDER BY a.account_type,cards DESC;

-- Actual result snapshot from uploaded data:
--           account_type card_type  cards  active_cards
--      Business Checking     Debit     55             3
--      Business Checking    Credit     34             4
-- Certificate of Deposit     Debit     65             6
-- Certificate of Deposit    Credit     51             1
--               Checking     Debit     54             3
--               Checking    Credit     24             3
--                    IRA     Debit     70             3
--                    IRA    Credit     48             2
--           Money Market     Debit     49             4
--           Money Market    Credit     46             2

-- Customer product engagement by segment
SELECT c.segment,
       COUNT(DISTINCT c.customer_id) AS customers,
       COUNT(DISTINCT a.account_id) AS accounts,
       COUNT(DISTINCT ca.card_id) AS cards,
       COUNT(DISTINCT l.loan_id) AS loans
FROM customers c
LEFT JOIN accounts a ON c.customer_id=a.customer_id
LEFT JOIN cards ca ON a.account_id=ca.account_id
LEFT JOIN loans l ON c.customer_id=l.customer_id
GROUP BY c.segment
ORDER BY customers DESC;

-- Actual result snapshot from uploaded data:
--  segment  customers  accounts  cards  loans
--  Student        100       134     98     62
-- Business         97       148    125     51
--   Retail         80       115    107     45
--  Premium         76        93     81     35
--   Wealth         74       102     87     47
--   Senior         73       108    102     60

-- Customers with accounts and at least one additional product
SELECT c.customer_id,c.segment,
       COUNT(DISTINCT a.account_id) AS accounts,
       COUNT(DISTINCT ca.card_id) AS cards,
       COUNT(DISTINCT l.loan_id) AS loans
FROM customers c
LEFT JOIN accounts a ON c.customer_id=a.customer_id
LEFT JOIN cards ca ON a.account_id=ca.account_id
LEFT JOIN loans l ON c.customer_id=l.customer_id
GROUP BY c.customer_id,c.segment
HAVING COUNT(DISTINCT a.account_id)>0
   AND (COUNT(DISTINCT ca.card_id)>0 OR COUNT(DISTINCT l.loan_id)>0)
ORDER BY accounts+cards+loans DESC
LIMIT 25;

-- Actual result snapshot from uploaded data:
-- customer_id  segment  accounts  cards  loans
--     C000226   Senior         8     12      0
--     C000146 Business         6     11      0
--     C000009   Retail         4      7      1
--     C000325  Student         5      5      2
--     C000345   Wealth         5      4      2
--     C000214   Senior         4      5      1
--     C000389 Business         3      6      1
--     C000446   Retail         3      3      4
--     C000001   Retail         4      5      0
--     C000139   Wealth         4      4      1

