-- ============================================================
-- RETAIL BANK ANALYSIS | 03_BASIC_ANALYSIS.sql
-- ============================================================
USE retail_bank;

-- Total customers
SELECT COUNT(*) AS total_customers FROM customers;

-- Actual result snapshot from uploaded data:
--  total_customers
--              500

-- Total accounts
SELECT COUNT(*) AS total_accounts FROM accounts;

-- Actual result snapshot from uploaded data:
--  total_accounts
--             700

-- Active customers
SELECT COUNT(*) AS active_customers FROM customers WHERE is_active = 'Yes';

-- Actual result snapshot from uploaded data:
--  active_customers
--               375

-- Account types
SELECT account_type, COUNT(*) AS account_count FROM accounts GROUP BY account_type ORDER BY account_count DESC;

-- Actual result snapshot from uploaded data:
--           account_type  account_count
--                    IRA            136
-- Certificate of Deposit            118
--                Savings            117
--      Business Checking            116
--           Money Market            110
--               Checking            103

-- Transaction types
SELECT transaction_type, COUNT(*) AS transaction_count FROM transactions GROUP BY transaction_type ORDER BY transaction_count DESC;

-- Actual result snapshot from uploaded data:
-- transaction_type  transaction_count
--         Transfer                858
--   ATM Withdrawal                857
--         Interest                855
--            Debit                828
--           Credit                818
--              Fee                784

-- Completed transaction amount
SELECT ROUND(SUM(amount),2) AS total_completed_transaction_amount FROM transactions WHERE status='Completed';

-- Actual result snapshot from uploaded data:
--  total_completed_transaction_amount
--                         10976552.36

-- Loan types
SELECT loan_type, COUNT(*) AS loan_count FROM loans GROUP BY loan_type ORDER BY loan_count DESC;

-- Actual result snapshot from uploaded data:
--      loan_type  loan_count
--      Education          64
--       Business          52
-- Credit Builder          49
--           Auto          48
--       Personal          45
--           Home          42

-- Total loans
SELECT COUNT(*) AS total_loans FROM loans;

-- Actual result snapshot from uploaded data:
--  total_loans
--          300

-- Card types
SELECT card_type, COUNT(*) AS card_count FROM cards GROUP BY card_type ORDER BY card_count DESC;

-- Actual result snapshot from uploaded data:
-- card_type  card_count
--     Debit         358
--    Credit         242

-- Outstanding loan balance
SELECT ROUND(SUM(outstanding_balance),2) AS total_outstanding_loan_balance FROM loans;

-- Actual result snapshot from uploaded data:
--  total_outstanding_loan_balance
--                     53441891.25

