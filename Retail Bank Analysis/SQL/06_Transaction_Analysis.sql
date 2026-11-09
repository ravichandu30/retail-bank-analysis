-- ============================================================
-- RETAIL BANK ANALYSIS | 06_Transaction_Analysis.sql
-- MySQL 8.x
-- ============================================================
USE retail_bank;

-- Transactions by type
SELECT transaction_type, COUNT(*) AS transactions,
       ROUND(SUM(CASE WHEN status='Completed' THEN amount ELSE 0 END),2) AS completed_amount
FROM transactions
GROUP BY transaction_type
ORDER BY completed_amount DESC;

-- Actual result snapshot from uploaded data:
-- transaction_type  transactions  completed_amount
--           Credit           818        2338007.84
--         Interest           855        2189474.17
--         Transfer           858        1799783.34
--            Debit           828        1613463.57
--   ATM Withdrawal           857        1549386.01
--              Fee           784        1486437.43

-- Transactions by channel
SELECT channel, COUNT(*) AS transactions,
       ROUND(SUM(CASE WHEN status='Completed' THEN amount ELSE 0 END),2) AS completed_amount
FROM transactions
GROUP BY channel
ORDER BY transactions DESC;

-- Actual result snapshot from uploaded data:
--       channel  transactions  completed_amount
--        Online          1470        3455257.94
--        Branch          1144        2701804.69
--        Mobile          1024        2305237.43
--           ATM           857        1549386.01
--           POS           281         525320.23
-- Wire Transfer           224         439546.06

-- Transaction status
SELECT status, COUNT(*) AS transactions,
       ROUND(SUM(amount),2) AS transaction_amount
FROM transactions
GROUP BY status
ORDER BY transactions DESC;

-- Actual result snapshot from uploaded data:
--    status  transactions  transaction_amount
-- Completed          1688         10976552.36
--   Pending          1684         12455487.22
--    Failed          1628         12459167.71

-- Transaction activity by customer segment
SELECT c.segment,
       COUNT(t.transaction_id) AS transactions,
       ROUND(SUM(CASE WHEN t.status='Completed' THEN t.amount ELSE 0 END),2) AS completed_amount
FROM transactions t
JOIN accounts a ON t.account_id=a.account_id
JOIN customers c ON a.customer_id=c.customer_id
GROUP BY c.segment
ORDER BY completed_amount DESC;

-- Actual result snapshot from uploaded data:
--  segment  transactions  completed_amount
-- Business          1054        2420559.91
--  Student           938        1970195.57
--   Retail           826        1943837.74
--   Senior           786        1670078.21
--   Wealth           733        1549248.99
--  Premium           663        1422631.94

-- Monthly completed transaction trend
SELECT DATE_FORMAT(transaction_date,'%Y-%m') AS 'year_month',
       COUNT(*) AS transactions,
       ROUND(SUM(CASE WHEN status='Completed' THEN amount ELSE 0 END),2) AS completed_amount
FROM transactions
GROUP BY DATE_FORMAT(transaction_date,'%Y-%m')
ORDER BY 'year_month';

-- Actual result snapshot from uploaded data:
-- year_month  transactions  completed_amount
--    2016-02             1              0.00
--    2016-05             1           2118.31
--    2017-02             1              0.00
--    2017-08             1              0.00
--    2017-12             2            371.98
--    2018-01             3              0.00
--    2018-02             1              0.00
--    2018-06             1              0.00
--    2018-08             1            460.10
--    2018-10             2              0.00

-- Top transaction descriptions
SELECT description, COUNT(*) AS transactions,
       ROUND(SUM(CASE WHEN status='Completed' THEN amount ELSE 0 END),2) AS completed_amount
FROM transactions
GROUP BY description
ORDER BY transactions DESC;

-- Actual result snapshot from uploaded data:
-- description  transactions  completed_amount
--  Investment          1404        3699812.36
--     Utility          1320        2514575.69
--        Rent           905        1668608.79
--    Purchase           559        1035512.32
--      Refund           282         732037.04
--      Salary           280         800997.80
--    Transfer           250         525008.36

