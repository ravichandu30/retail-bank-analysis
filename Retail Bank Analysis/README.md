# Retail Bank SQL Deliverables

These SQL files were created from the uploaded Retail Banking CSV datasets and the supplied project documentation.

## Files
- 01_Database_Setup.sql — MySQL 8.x database/table definitions and LOAD DATA template.
- 02_Data_Validation.sql — row counts, duplicate-key checks, orphan checks, null/date checks and categorical whitespace checks.
- 03_Basic_Analysis.sql — the 10 basic Sprint 3 questions from the project brief.
- 04_Customer_Analysis.sql — customer profile and segmentation.
- 05_Account_Branch_Analysis.sql — account usage and branch activity.
- 06_Transaction_Analysis.sql — transaction patterns and channels.
- 07_Loan_Analysis.sql — loan portfolio and repayment behaviour.
- 08_Card_Product_Engagement.sql — card usage and broader product engagement.

## Verification
The analytical queries were executed against an in-memory SQL database loaded from the uploaded CSV files to verify the outputs. The SQL delivered here is written for MySQL 8.x.

Each analysis file includes a commented "Actual result snapshot from uploaded data" immediately below the corresponding query. These snapshots are evidence of the current uploaded data and are not manually invented.

## Important
The SQL files do not modify the source CSVs. For the Power BI portion, the project brief expects cleaning/modeling in Power Query and a transparent Applied Steps record.
