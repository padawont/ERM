-- This file should undo anything in `up.sql`

-- Drop tables in reverse order of creation to handle dependencies

DROP TABLE IF EXISTS account_details;
DROP TABLE IF EXISTS income;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS checks;
DROP TABLE IF EXISTS tax_money;
DROP TABLE IF EXISTS tax;
DROP TABLE IF EXISTS account_invoice;
DROP TABLE IF EXISTS account_receivable_customer;
DROP TABLE IF EXISTS account_payable_vendor;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS vendor;
DROP TABLE IF EXISTS account_receivable;
DROP TABLE IF EXISTS account_payable;
DROP TABLE IF EXISTS company_account;
DROP TABLE IF EXISTS finance_period;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS list_item;
DROP TABLE IF EXISTS invoice;
DROP TABLE IF EXISTS incoterms;
DROP TABLE IF EXISTS currency;
DROP TABLE IF EXISTS role_permissions;
DROP TABLE IF EXISTS permissions;
DROP TABLE IF EXISTS role_user;
DROP TABLE IF EXISTS role;
DROP TABLE IF EXISTS company_user;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS location;
DROP TABLE IF EXISTS office;
DROP TABLE IF EXISTS company;
