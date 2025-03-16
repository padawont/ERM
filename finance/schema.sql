-- Create Enum Types
CREATE TYPE account_status AS ENUM ('active', 'inactive', 'pending');
CREATE TYPE account_type AS ENUM ('asset', 'liability', 'equity', 'revenue', 'expense');
CREATE TYPE tax_money_type AS ENUM ('check', 'payment', 'invoice', 'income');

-- Create Tables
CREATE TABLE company (
    id SERIAL PRIMARY KEY,
    email_address VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    timestamp DATE
);

CREATE TABLE office (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL REFERENCES company(id)
);

CREATE TABLE location (
    id SERIAL PRIMARY KEY,
    office_id INT NOT NULL REFERENCES office(id),
    address VARCHAR(255),  -- Fixed typo from 'adddress'
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
    user_id INT NOT NULL REFERENCES users(id),
    company_id INT NOT NULL REFERENCES company(id)
);

CREATE TABLE role (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT  -- Fixed typo from 'desrciption'
);

CREATE TABLE role_user (
    id SERIAL PRIMARY KEY,
    role_id INT NOT NULL REFERENCES role(id),
    user_id INT NOT NULL REFERENCES users(id)
);

CREATE TABLE permissions (
    id SERIAL PRIMARY KEY,
    description TEXT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE role_permissions (  -- Fixed typo from 'permisstions'
    id SERIAL PRIMARY KEY,
    permission_id INT NOT NULL REFERENCES permissions(id),
    role_id INT NOT NULL REFERENCES role(id)
);

CREATE TABLE currency (
    id SERIAL PRIMARY KEY,
    currency_name VARCHAR(255) NOT NULL,
    currency_code INT NOT NULL,
    country VARCHAR(255) NOT NULL,
    exchange_rate DECIMAL NOT NULL
);

CREATE TABLE incoterms (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE invoice (
    id SERIAL PRIMARY KEY,
    invoice_number INT NOT NULL,
    starting_date DATE NOT NULL,
    ending_date DATE NOT NULL,
    sender_info TEXT NOT NULL,
    subtotal DECIMAL NOT NULL,
    payment_instructions TEXT,  -- Fixed typo from 'instruections'
    notes TEXT,
    currency_id INT NOT NULL REFERENCES currency(id),
    incoterms_id INT REFERENCES incoterms(id)
);

CREATE TABLE list_item (
    id SERIAL PRIMARY KEY,
    quantity INT NOT NULL,  -- Fixed typo from 'quantitiy'
    description TEXT NOT NULL,
    unit_price DECIMAL NOT NULL,
    total DECIMAL NOT NULL,
    invoice_id INT NOT NULL REFERENCES invoice(id)
);

CREATE TABLE account (
    id SERIAL PRIMARY KEY,
    currency_id INT NOT NULL REFERENCES currency(id),
    credit DECIMAL NOT NULL DEFAULT 0,
    debit DECIMAL NOT NULL DEFAULT 0,
    account_type account_type NOT NULL
);

CREATE TABLE finance_period (  -- Fixed typo from 'finace_period'
    id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES account(id),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status account_status NOT NULL
);

CREATE TABLE company_account (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL REFERENCES company(id),
    account_id INT NOT NULL REFERENCES account(id)
);

-- Payment-related tables
CREATE TABLE account_payable (
    id SERIAL PRIMARY KEY,
    currency_id INT NOT NULL REFERENCES currency(id),
    due_date DATE NOT NULL,
    status account_status NOT NULL,
    amount DECIMAL NOT NULL,
    terms TEXT
);

CREATE TABLE account_receivable (
    id SERIAL PRIMARY KEY,
    currency_id INT NOT NULL REFERENCES currency(id),
    due_date DATE NOT NULL,
    status account_status NOT NULL,
    terms TEXT,
    amount DECIMAL NOT NULL
);

CREATE TABLE vendor (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(255) NOT NULL
);

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    phone_number VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

-- Junction tables
CREATE TABLE account_payable_vendor (
    id SERIAL PRIMARY KEY,
    account_payable_id INT NOT NULL REFERENCES account_payable(id),
    vendor_id INT NOT NULL REFERENCES vendor(id)
);

CREATE TABLE account_receivable_customer (
    id SERIAL PRIMARY KEY,
    account_receivable_id INT NOT NULL REFERENCES account_receivable(id),
    customer_id INT NOT NULL REFERENCES customers(id)
);

CREATE TABLE account_invoice (
    id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES account(id),
    invoice_id INT NOT NULL REFERENCES invoice(id),
    account_is_payable BOOLEAN NOT NULL
);

-- Tax-related tables
CREATE TABLE tax (
    id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES account(id),
    location_id INT NOT NULL REFERENCES location(id),
    tax_rate DECIMAL NOT NULL,
    tax_total DECIMAL NOT NULL
);

CREATE TABLE tax_money (
    id SERIAL PRIMARY KEY,
    tax_id INT NOT NULL REFERENCES tax(id),
    money_id INT NOT NULL,
    money_type tax_money_type NOT NULL
);

-- Financial transaction tables
CREATE TABLE checks (
    id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES account(id),
    currency_id INT NOT NULL REFERENCES currency(id),
    amount DECIMAL NOT NULL
);

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL REFERENCES company(id),
    currency_id INT NOT NULL REFERENCES currency(id),
    amount DECIMAL NOT NULL
);

CREATE TABLE income (
    id SERIAL PRIMARY KEY,
    company_id INT NOT NULL REFERENCES company(id),
    currency_id INT NOT NULL REFERENCES currency(id),
    amount DECIMAL NOT NULL
);

-- Account details
CREATE TABLE account_details (
    id SERIAL PRIMARY KEY,
    account_id INT NOT NULL REFERENCES account(id),  -- Fixed typo from 'acount'
    bank_name VARCHAR(255),
    branch_name VARCHAR(255),
    swift_code VARCHAR(255),
    ifsc_code VARCHAR(255),
    routing_number INT,
    iban VARCHAR(255),
    bank_website VARCHAR(255)
);