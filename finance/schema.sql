-- Create Tables
CREATE TABLE company (
    id SERIAL PRIMARY KEY,
    email_address VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    timestamp DATE DEFAULT CURRENT_DATE
);

CREATE TABLE office (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE
);

CREATE TABLE location (
    id SERIAL PRIMARY KEY,
    office_id INT NOT NULL REFERENCES office(id) ON DELETE CASCADE,
    address VARCHAR(255),
    city VARCHAR(255),
    country VARCHAR(255)
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email_address VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE company_user (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE
);

CREATE TABLE role (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE role_user (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL REFERENCES role(id) ON DELETE CASCADE,
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE permissions (
    id SERIAL PRIMARY KEY,
    description TEXT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE role_permissions (
    id SERIAL PRIMARY KEY,
    permission_id INT NOT NULL REFERENCES permissions(id) ON DELETE CASCADE,
    role_id INT NOT NULL REFERENCES role(id) ON DELETE CASCADE
);

CREATE TABLE currency (
    id SERIAL PRIMARY KEY,
    currency_name VARCHAR(255) NOT NULL,
    currency_code VARCHAR(3) NOT NULL UNIQUE,
    country VARCHAR(255) NOT NULL,
    exchange_rate DECIMAL(18,6) NOT NULL
);

CREATE TABLE incoterms (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE invoice (
    id SERIAL PRIMARY KEY,
    invoice_number INT NOT NULL UNIQUE,
    starting_date DATE NOT NULL,
    ending_date DATE NOT NULL,
    sender_info TEXT NOT NULL,
    subtotal DECIMAL(18,2) NOT NULL,
    payment_instructions TEXT,
    notes TEXT,
    currency_id INT NOT NULL REFERENCES currency(id) ON DELETE CASCADE,
    incoterms_id INT REFERENCES incoterms(id) ON DELETE SET NULL
);

CREATE TABLE list_item (
    id SERIAL PRIMARY KEY,
    quantity INT NOT NULL,
    description TEXT NOT NULL,
    unit_price DECIMAL(18,2) NOT NULL,
    total DECIMAL(18,2) NOT NULL,
    invoice_id INT NOT NULL REFERENCES invoice(id) ON DELETE CASCADE
);

CREATE TABLE account (
    id SERIAL PRIMARY KEY,
    currency_id INT NOT NULL REFERENCES currency(id) ON DELETE CASCADE,
    credit DECIMAL(18,2) NOT NULL DEFAULT 0,
    debit DECIMAL(18,2) NOT NULL DEFAULT 0,
    account_type CHAR(10) NOT NULL CHECK (account_type IN ('asset', 'liability', 'equity', 'revenue', 'expense'))
);

CREATE TABLE finance_period (
    id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES account(id) ON DELETE CASCADE,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status CHAR(10) NOT NULL CHECK (status IN ('active', 'inactive', 'pending'))
);

CREATE TABLE company_account (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
    account_id INT NOT NULL REFERENCES account(id) ON DELETE CASCADE
);

-- Payment-related tables
CREATE TABLE account_payable (
    id SERIAL PRIMARY KEY,
    currency_id INT NOT NULL REFERENCES currency(id) ON DELETE CASCADE,
    due_date DATE NOT NULL,
    status CHAR(10) NOT NULL CHECK (status IN ('active', 'inactive', 'pending')),
    amount DECIMAL(18,2) NOT NULL,
    terms TEXT
);

CREATE TABLE account_receivable (
    id SERIAL PRIMARY KEY,
    currency_id INT NOT NULL REFERENCES currency(id) ON DELETE CASCADE,
    due_date DATE NOT NULL,
    status CHAR(10) NOT NULL CHECK (status IN ('active', 'inactive', 'pending')),
    terms TEXT,
    amount DECIMAL(18,2) NOT NULL
);

CREATE TABLE vendor (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL
);

-- Junction tables
CREATE TABLE account_payable_vendor (
    id SERIAL PRIMARY KEY,
    account_payable_id INT NOT NULL REFERENCES account_payable(id) ON DELETE CASCADE,
    vendor_id INT NOT NULL REFERENCES vendor(id) ON DELETE CASCADE
);

CREATE TABLE account_receivable_customer (
    id SERIAL PRIMARY KEY,
    account_receivable_id INT NOT NULL REFERENCES account_receivable(id) ON DELETE CASCADE,
    customer_id INT NOT NULL REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE account_invoice (
    id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES account(id) ON DELETE CASCADE,
    invoice_id INT NOT NULL REFERENCES invoice(id) ON DELETE CASCADE,
    account_is_payable BOOLEAN NOT NULL
);

-- Tax-related tables
CREATE TABLE tax (
    id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES account(id) ON DELETE CASCADE,
    location_id INT NOT NULL REFERENCES location(id) ON DELETE CASCADE,
    tax_rate DECIMAL(5,2) NOT NULL,
    tax_total DECIMAL(18,2) NOT NULL
);

CREATE TABLE tax_money (
    id SERIAL PRIMARY KEY,
    tax_id INT NOT NULL REFERENCES tax(id) ON DELETE CASCADE,
    money_id INT NOT NULL,
    money_type CHAR(10) NOT NULL CHECK (money_type IN ('check', 'payment', 'invoice', 'income'))
);

-- Financial transaction tables
CREATE TABLE checks (
    id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES account(id) ON DELETE CASCADE,
    currency_id INT NOT NULL REFERENCES currency(id) ON DELETE CASCADE,
    amount DECIMAL(18,2) NOT NULL
);

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
    currency_id INT NOT NULL REFERENCES currency(id) ON DELETE CASCADE,
    amount DECIMAL(18,2) NOT NULL
);

CREATE TABLE income (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL REFERENCES company(id) ON DELETE CASCADE,
    currency_id INT NOT NULL REFERENCES currency(id) ON DELETE CASCADE,
    amount DECIMAL(18,2) NOT NULL
);

-- Account details
CREATE TABLE account_details (
    id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES account(id) ON DELETE CASCADE,
    bank_name VARCHAR(255),
    branch_name VARCHAR(255),
    swift_code VARCHAR(11),
    ifsc_code VARCHAR(11),
    routing_number VARCHAR(20),
    iban VARCHAR(34),
    bank_website VARCHAR(255)
);
