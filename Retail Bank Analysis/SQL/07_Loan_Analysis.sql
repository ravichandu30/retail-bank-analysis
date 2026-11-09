-- ============================================================
-- RETAIL BANK ANALYSIS | 07_Loan_Analysis.sql
-- MySQL 8.x
-- ============================================================
USE retail_bank;

-- Loan portfolio by type
SELECT loan_type, COUNT(*) AS loans,
       ROUND(SUM(principal_amount),2) AS principal,
       ROUND(SUM(outstanding_balance),2) AS outstanding
FROM loans
GROUP BY loan_type
ORDER BY outstanding DESC;

-- Actual result snapshot from uploaded data:
--      loan_type  loans   principal  outstanding
--      Education     64 15738129.44  10937737.62
--       Business     52 12426117.77  10056247.55
--           Home     42 10910304.51   8364122.07
-- Credit Builder     49 11185814.72   8300285.39
--           Auto     48 11450808.86   8107012.68
--       Personal     45 10499100.89   7676485.94

-- Loan status distribution
SELECT loan_status, COUNT(*) AS loans,
       ROUND(SUM(outstanding_balance),2) AS outstanding
FROM loans
GROUP BY loan_status
ORDER BY loans DESC;

-- Actual result snapshot from uploaded data:
-- loan_status  loans  outstanding
--   Defaulted     86  18595217.92
--  In Arrears     83  20569787.74
--      Closed     66         0.00
--      Active     65  14276885.59

-- Branch loan performance
SELECT b.branch_id,b.branch_name,b.region,
       COUNT(l.loan_id) AS loans,
       ROUND(SUM(l.principal_amount),2) AS principal,
       ROUND(SUM(l.outstanding_balance),2) AS outstanding
FROM branches b
LEFT JOIN loans l ON b.branch_id=l.branch_id
GROUP BY b.branch_id,b.branch_name,b.region
ORDER BY outstanding DESC;

-- Actual result snapshot from uploaded data:
-- branch_id           branch_name  region  loans  principal  outstanding
--     BR032         Austin Branch   South     14 3803272.38   2893214.67
--     BR001   Jacksonville Branch   South      9 2862456.50   2623874.87
--     BR017          Omaha Branch Central     12 3159367.71   2437785.88
--     BR038    Los Angeles Branch    West      9 2913473.57   2374339.76
--     BR035        Atlanta Branch   South     12 3196284.02   2267675.76
--     BR039     Sacramento Branch    West     11 2412211.37   2118590.82
--     BR031        Atlanta Branch   South      9 1914037.57   1791849.28
--     BR007 Virginia Beach Branch   South      8 2212721.94   1753182.38
--     BR010        Memphis Branch   South     10 2572882.76   1747295.46
--     BR033         Boston Branch    East      9 1875648.77   1665651.92

-- Loan repayment status
SELECT status, COUNT(*) AS payments,
       ROUND(SUM(scheduled_amount),2) AS scheduled_amount,
       ROUND(SUM(paid_amount),2) AS paid_amount,
       ROUND(AVG(days_late),2) AS avg_days_late
FROM loan_payments
GROUP BY status
ORDER BY payments DESC;

-- Actual result snapshot from uploaded data:
--  status  payments  scheduled_amount  paid_amount  avg_days_late
--    Paid       573        3651106.85  13382599.68           0.00
--    Late       500        2910025.93   7878454.82          22.52
--  Missed       468        2823560.23         0.00           0.00
-- Pending       459        2715508.68         0.00           0.00

-- Late payment rate by loan type
SELECT l.loan_type,
       COUNT(p.payment_id) AS payments,
       SUM(CASE WHEN p.days_late>0 THEN 1 ELSE 0 END) AS late_payments,
       ROUND(100.0*SUM(CASE WHEN p.days_late>0 THEN 1 ELSE 0 END)/COUNT(p.payment_id),2) AS late_rate_pct
FROM loans l
JOIN loan_payments p ON l.loan_id=p.loan_id
GROUP BY l.loan_type
ORDER BY late_rate_pct DESC;

-- Actual result snapshot from uploaded data:
--      loan_type  payments  late_payments  late_rate_pct
--           Home       309             87          28.16
--       Business       334             90          26.95
--           Auto       303             79          26.07
--       Personal       317             78          24.61
--      Education       424             98          23.11
-- Credit Builder       313             68          21.73

-- Payment method performance
SELECT payment_method, COUNT(*) AS payments,
       ROUND(SUM(paid_amount),2) AS paid_amount,
       ROUND(AVG(days_late),2) AS avg_days_late
FROM loan_payments
GROUP BY payment_method
ORDER BY paid_amount DESC;

-- Actual result snapshot from uploaded data:
-- payment_method  payments  paid_amount  avg_days_late
--  Bank Transfer       385   4546526.89           5.11
--         Cheque       388   4162727.02           6.06
--           Cash       375   4082018.86           6.52
--     Debit Card       360   3088106.72           5.11
--    Credit Card       247   2835731.70           5.91
-- Online Banking       133   1652082.00           5.24
--     Auto Debit       112    893861.31           4.46

-- Loans with highest outstanding balance
SELECT loan_id, customer_id, loan_type, loan_status,
       ROUND(principal_amount,2) AS principal_amount,
       ROUND(outstanding_balance,2) AS outstanding_balance
FROM loans
ORDER BY outstanding_balance DESC
LIMIT 20;

-- Actual result snapshot from uploaded data:
-- loan_id customer_id      loan_type loan_status  principal_amount  outstanding_balance
-- L000280     C000089      Education  In Arrears         487318.17            478873.28
-- L000183     C000441           Auto  In Arrears         473036.34            470805.82
-- L000034     C000350 Credit Builder  In Arrears         493696.15            470735.37
-- L000163     C000048           Auto      Active         484137.79            466505.87
-- L000248     C000060       Business  In Arrears         485653.96            457240.64
-- L000021     C000254           Auto   Defaulted         488732.99            453314.30
-- L000300     C000384 Credit Builder  In Arrears         479422.09            452959.45
-- L000071     C000022      Education      Active         484256.02            450936.98
-- L000147     C000228 Credit Builder   Defaulted         458781.36            449638.55
-- L000112     C000180       Personal   Defaulted         461274.34            449416.37

