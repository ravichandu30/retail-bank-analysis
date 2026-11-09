-- ============================================================
-- RETAIL BANK ANALYSIS | 02_DATA_VALIDATION.sql
-- ============================================================
USE retail_bank;

-- Table row counts
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL SELECT 'accounts', COUNT(*) FROM accounts
UNION ALL SELECT 'branches', COUNT(*) FROM branches
UNION ALL SELECT 'cards', COUNT(*) FROM cards
UNION ALL SELECT 'loans', COUNT(*) FROM loans
UNION ALL SELECT 'loan_payments', COUNT(*) FROM loan_payments
UNION ALL SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL SELECT 'date_table', COUNT(*) FROM date_table;

-- Duplicate customer IDs
SELECT customer_id, COUNT(*) AS duplicate_count FROM customers GROUP BY customer_id HAVING COUNT(*) > 1;

-- Duplicate account IDs
SELECT account_id, COUNT(*) AS duplicate_count FROM accounts GROUP BY account_id HAVING COUNT(*) > 1;

-- Orphan accounts -> customers
SELECT a.account_id, a.customer_id FROM accounts a LEFT JOIN customers c ON a.customer_id=c.customer_id WHERE c.customer_id IS NULL;

-- Orphan accounts -> branches
SELECT a.account_id, a.branch_id FROM accounts a LEFT JOIN branches b ON a.branch_id=b.branch_id WHERE b.branch_id IS NULL;

-- Orphan cards -> accounts
SELECT c.card_id, c.account_id FROM cards c LEFT JOIN accounts a ON c.account_id=a.account_id WHERE a.account_id IS NULL;

-- Orphan loans -> customers
SELECT l.loan_id, l.customer_id FROM loans l LEFT JOIN customers c ON l.customer_id=c.customer_id WHERE c.customer_id IS NULL;

-- Orphan loan payments -> loans
SELECT p.payment_id, p.loan_id FROM loan_payments p LEFT JOIN loans l ON p.loan_id=l.loan_id WHERE l.loan_id IS NULL;

-- Orphan transactions -> accounts
SELECT t.transaction_id, t.account_id FROM transactions t LEFT JOIN accounts a ON t.account_id=a.account_id WHERE a.account_id IS NULL;

-- Accounts with NULL close date
SELECT COUNT(*) AS accounts_without_close_date FROM accounts WHERE close_date IS NULL;

-- Transaction date range
SELECT MIN(transaction_date) AS min_transaction_date, MAX(transaction_date) AS max_transaction_date FROM transactions;

-- Categorical whitespace check
SELECT 'customers.gender' AS field, COUNT(*) AS whitespace_rows FROM customers WHERE gender <> TRIM(gender)
UNION ALL SELECT 'customers.segment', COUNT(*) FROM customers WHERE segment <> TRIM(segment)
UNION ALL SELECT 'accounts.account_type', COUNT(*) FROM accounts WHERE account_type <> TRIM(account_type)
UNION ALL SELECT 'cards.network', COUNT(*) FROM cards WHERE network <> TRIM(network)
UNION ALL SELECT 'loans.loan_type', COUNT(*) FROM loans WHERE loan_type <> TRIM(loan_type)
UNION ALL SELECT 'transactions.channel', COUNT(*) FROM transactions WHERE channel <> TRIM(channel);

