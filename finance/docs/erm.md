```Mermaid
erDiagram
    %% ——— PRIMARY ENTITIES ———
    %% -- Core Business Entities --
    company {
        id serial PK
        email_address varchar
        name varchar
        timestamp date
    }
    users {
        id serial PK
        email_address varchar
        name varchar
    }
    customers {
        id serial PK
        phone_number varchar
        email varchar
    }
    vendor {
        id serial PK
        email varchar
        phone_number varchar
    }
    
    %% -- Reference Entities --
    currency {
        id serial PK
        currency_name varchar
        currency_code varchar
        country varchar
        exchange_rate numeric
    }
    incoterms {
        id serial PK
        name varchar
        description text
    }
    
    %% -- Authorization Entities --
    permissions {
        id serial PK
        description text
        name varchar
    }
    role {
        id serial PK
        title varchar
        description text
    }
    
    %% ——— ACCOUNT ENTITIES ———
    %% -- Core Account --
    account {
        id serial PK
        currency_id int FK
        credit float
        debit float
        account_type bpchar
        created_at timestamp
    }
    account_details {
        id serial PK
        account_id int FK
        bank_name varchar
        branch_name varchar
        swift_code varchar
        ifsc_code varchar
        routing_number varchar
        iban varchar
        bank_website varchar
    }
    finance_period {
        id serial PK
        account_id int FK
        start_date date
        end_date date
        status bpchar
    }
    
    %% -- Accounts Payable/Receivable --
    account_payable {
        id serial PK
        currency_id int FK
        due_date date
        status bpchar
        amount numeric
        terms text
    }
    account_payable_vendor {
        id serial PK
        account_payable_id int FK
        vendor_id int FK
    }
    account_receivable {
        id serial PK
        currency_id int FK
        due_date date
        status bpchar
        terms text
        amount numeric
    }
    account_receivable_customer {
        id serial PK
        account_receivable_id int FK
        customer_id int FK
    }
    
    %% ——— FINANCIAL ENTITIES ———
    %% -- Transaction Records --
    checks {
        id serial PK
        account_id int FK
        currency_id int FK
        amount numeric
    }
    income {
        id serial PK
        company_id int FK
        currency_id int FK
        amount numeric
    }
    payments {
        id serial PK
        company_id int FK
        currency_id int FK
        amount numeric
    }
    
    %% -- Invoicing --
    invoice {
        id serial PK
        invoice_number int
        starting_date date
        ending_date date
        sender_info text
        subtotal numeric
        payment_instructions text
        notes text
        currency_id int FK
        incoterms_id int FK
    }
    list_item {
        id serial PK
        quantity int
        description text
        unit_price numeric
        total numeric
        invoice_id int FK
    }
    
    %% -- Taxation --
    tax {
        id serial PK
        account_id int FK
        location_id int FK
        tax_rate numeric
        tax_total numeric
    }
    tax_money {
        id serial PK
        tax_id int FK
        money_id int FK
        money_type bpchar
    }
    
    %% ——— RELATIONSHIP ENTITIES ———
    %% -- Company Relationships --
    company_account {
        id serial PK
        company_id int FK
        account_id int FK
    }
    company_user {
        id serial PK
        user_id int FK
        company_id int FK
    }
    office {
        id serial PK
        company_id int FK
    }
    location {
        id serial PK
        office_id int FK
        address varchar
        city varchar
        country varchar
    }
    
    %% -- User Relationships --
    role_permissions {
        id serial PK
        permission_id int FK
        role_id int FK
    }
    role_user {
        id serial PK
        role_id int FK
        user_id int FK
    }
    
    %% -- Financial Relationships --
    account_invoice {
        id serial PK
        account_id int FK
        invoice_id int FK
        account_is_payable bool
    }
    
    %% ——— RELATIONSHIPS ———
    account ||--|| currency : currency_id
    account_details ||--|| account : account_id
    account_payable ||--|| currency : currency_id
    account_payable_vendor ||--|| account_payable : account_payable_id
    account_payable_vendor ||--|| vendor : vendor_id
    account_receivable ||--|| currency : currency_id
    account_receivable_customer ||--|| account_receivable : account_receivable_id
    account_receivable_customer ||--|| customers : customer_id
    checks ||--|| account : account_id
    checks ||--|| currency : currency_id
    company_account ||--|| company : company_id
    company_account ||--|| account : account_id
    company_user ||--|| users : user_id
    company_user ||--|| company : company_id
    finance_period ||--|| account : account_id
    income ||--|| company : company_id
    income ||--|| currency : currency_id
    invoice ||--|| currency : currency_id
    invoice ||--o{ incoterms : incoterms_id
    list_item ||--|| invoice : invoice_id
    office ||--|| company : company_id
    payments ||--|| company : company_id
    payments ||--|| currency : currency_id
    role_permissions ||--|| permissions : permission_id
    role_permissions ||--|| role : role_id
    role_user ||--|| role : role_id
    role_user ||--|| users : user_id
    account_invoice ||--|| account : account_id
    account_invoice ||--|| invoice : invoice_id
    location ||--|| office : office_id
    tax ||--|| account : account_id
    tax ||--|| location : location_id
    tax_money ||--|| tax : tax_id
```
