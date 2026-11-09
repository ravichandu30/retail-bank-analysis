-- ============================================================
-- RETAIL BANK ANALYSIS | 01_DATABASE_SETUP.sql
-- MySQL 8.x
-- ============================================================

CREATE DATABASE IF NOT EXISTS retail_bank;
USE retail_bank;

-- Create parent tables before dependent tables.
CREATE TABLE branches (
    branch_id VARCHAR(10) PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    region VARCHAR(50) NOT NULL,
    opening_date DATE NOT NULL,
    employee_count INT NOT NULL
);

CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(30) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    customer_since DATE NOT NULL,
    kyc_status VARCHAR(30) NOT NULL,
    segment VARCHAR(30) NOT NULL,
    annual_income DECIMAL(15,2) NOT NULL,
    credit_score INT NOT NULL,
    is_active VARCHAR(5) NOT NULL
);

CREATE TABLE accounts (
    account_id VARCHAR(15) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    branch_id VARCHAR(10) NOT NULL,
    account_type VARCHAR(50) NOT NULL,
    open_date DATE NOT NULL,
    close_date DATE NULL,
    current_balance DECIMAL(18,2) NOT NULL,
    interest_rate DECIMAL(8,2) NOT NULL,
    overdraft_limit DECIMAL(18,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    CONSTRAINT fk_accounts_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_accounts_branch FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE loans (
    loan_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    branch_id VARCHAR(10) NOT NULL,
    loan_type VARCHAR(50) NOT NULL,
    principal_amount DECIMAL(18,2) NOT NULL,
    interest_rate DECIMAL(8,2) NOT NULL,
    tenure_months INT NOT NULL,
    disbursement_date DATE NOT NULL,
    maturity_date DATE NOT NULL,
    emi_amount DECIMAL(18,2) NOT NULL,
    outstanding_balance DECIMAL(18,2) NOT NULL,
    loan_status VARCHAR(30) NOT NULL,
    purpose VARCHAR(100) NOT NULL,
    CONSTRAINT fk_loans_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_loans_branch FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE cards (
    card_id VARCHAR(15) PRIMARY KEY,
    account_id VARCHAR(15) NOT NULL,
    card_type VARCHAR(30) NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    credit_limit DECIMAL(18,2) NOT NULL,
    outstanding_balance DECIMAL(18,2) NOT NULL,
    reward_points INT NOT NULL,
    is_active VARCHAR(5) NOT NULL,
    network VARCHAR(50) NOT NULL,
    CONSTRAINT fk_cards_account FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE loan_payments (
    payment_id VARCHAR(15) PRIMARY KEY,
    loan_id VARCHAR(10) NOT NULL,
    payment_date DATE NOT NULL,
    scheduled_amount DECIMAL(18,2) NOT NULL,
    paid_amount DECIMAL(18,2) NOT NULL,
    principal_paid DECIMAL(18,2) NOT NULL,
    interest_paid DECIMAL(18,2) NOT NULL,
    penalty DECIMAL(18,2) NOT NULL,
    days_late INT NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    status VARCHAR(30) NOT NULL,
    CONSTRAINT fk_payments_loan FOREIGN KEY (loan_id) REFERENCES loans(loan_id)
);

CREATE TABLE transactions (
    transaction_id VARCHAR(15) PRIMARY KEY,
    account_id VARCHAR(15) NOT NULL,
    transaction_date DATE NOT NULL,
    transaction_time TIME NOT NULL,
    transaction_type VARCHAR(50) NOT NULL,
    amount DECIMAL(18,2) NOT NULL,
    channel VARCHAR(50) NOT NULL,
    description VARCHAR(100) NOT NULL,
    balance_after DECIMAL(18,2) NOT NULL,
    status VARCHAR(30) NOT NULL,
    CONSTRAINT fk_transactions_account FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE date_table (
    `Date` DATE PRIMARY KEY,
    `Year` INT NOT NULL,
    MonthNumber INT NOT NULL,
    MonthName VARCHAR(20) NOT NULL,
    YearMonth VARCHAR(7) NOT NULL,
    Quarter VARCHAR(5) NOT NULL,
    Day INT NOT NULL,
    WeekdayNumber INT NOT NULL,
    WeekdayName VARCHAR(20) NOT NULL,
    IsWeekend BOOLEAN NOT NULL
);

-- Import with your local file paths after creating the tables.
-- Example:
-- LOAD DATA LOCAL INFILE 'C:/path/customers.csv'
-- INTO TABLE customers
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"'
-- IGNORE 1 ROWS;
--
-- Repeat for the remaining tables.
