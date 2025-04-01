// @generated automatically by Diesel CLI.

diesel::table! {
    account (id) {
        id -> Int4,
        currency_id -> Int4,
        credit -> Numeric,
        debit -> Numeric,
        #[max_length = 10]
        account_type -> Bpchar,
    }
}

diesel::table! {
    account_details (id) {
        id -> Int4,
        account_id -> Int4,
        #[max_length = 255]
        bank_name -> Nullable<Varchar>,
        #[max_length = 255]
        branch_name -> Nullable<Varchar>,
        #[max_length = 11]
        swift_code -> Nullable<Varchar>,
        #[max_length = 11]
        ifsc_code -> Nullable<Varchar>,
        #[max_length = 20]
        routing_number -> Nullable<Varchar>,
        #[max_length = 34]
        iban -> Nullable<Varchar>,
        #[max_length = 255]
        bank_website -> Nullable<Varchar>,
    }
}

diesel::table! {
    account_invoice (id) {
        id -> Int4,
        account_id -> Int4,
        invoice_id -> Int4,
        account_is_payable -> Bool,
    }
}

diesel::table! {
    account_payable (id) {
        id -> Int4,
        currency_id -> Int4,
        due_date -> Date,
        #[max_length = 10]
        status -> Bpchar,
        amount -> Numeric,
        terms -> Nullable<Text>,
    }
}

diesel::table! {
    account_payable_vendor (id) {
        id -> Int4,
        account_payable_id -> Int4,
        vendor_id -> Int4,
    }
}

diesel::table! {
    account_receivable (id) {
        id -> Int4,
        currency_id -> Int4,
        due_date -> Date,
        #[max_length = 10]
        status -> Bpchar,
        terms -> Nullable<Text>,
        amount -> Numeric,
    }
}

diesel::table! {
    account_receivable_customer (id) {
        id -> Int4,
        account_receivable_id -> Int4,
        customer_id -> Int4,
    }
}

diesel::table! {
    checks (id) {
        id -> Int4,
        account_id -> Int4,
        currency_id -> Int4,
        amount -> Numeric,
    }
}

diesel::table! {
    company (id) {
        id -> Int4,
        #[max_length = 255]
        email_address -> Nullable<Varchar>,
        #[max_length = 255]
        name -> Varchar,
        timestamp -> Nullable<Date>,
    }
}

diesel::table! {
    company_account (id) {
        id -> Int4,
        company_id -> Int4,
        account_id -> Int4,
    }
}

diesel::table! {
    company_user (id) {
        id -> Int4,
        user_id -> Int4,
        company_id -> Int4,
    }
}

diesel::table! {
    currency (id) {
        id -> Int4,
        #[max_length = 255]
        currency_name -> Varchar,
        #[max_length = 3]
        currency_code -> Varchar,
        #[max_length = 255]
        country -> Varchar,
        exchange_rate -> Numeric,
    }
}

diesel::table! {
    customers (id) {
        id -> Int4,
        #[max_length = 20]
        phone_number -> Varchar,
        #[max_length = 255]
        email -> Varchar,
    }
}

diesel::table! {
    finance_period (id) {
        id -> Int4,
        account_id -> Int4,
        start_date -> Date,
        end_date -> Date,
        #[max_length = 10]
        status -> Bpchar,
    }
}

diesel::table! {
    income (id) {
        id -> Int4,
        company_id -> Int4,
        currency_id -> Int4,
        amount -> Numeric,
    }
}

diesel::table! {
    incoterms (id) {
        id -> Int4,
        #[max_length = 255]
        name -> Varchar,
        description -> Nullable<Text>,
    }
}

diesel::table! {
    invoice (id) {
        id -> Int4,
        invoice_number -> Int4,
        starting_date -> Date,
        ending_date -> Date,
        sender_info -> Text,
        subtotal -> Numeric,
        payment_instructions -> Nullable<Text>,
        notes -> Nullable<Text>,
        currency_id -> Int4,
        incoterms_id -> Nullable<Int4>,
    }
}

diesel::table! {
    list_item (id) {
        id -> Int4,
        quantity -> Int4,
        description -> Text,
        unit_price -> Numeric,
        total -> Numeric,
        invoice_id -> Int4,
    }
}

diesel::table! {
    location (id) {
        id -> Int4,
        office_id -> Int4,
        #[max_length = 255]
        address -> Nullable<Varchar>,
        #[max_length = 255]
        city -> Nullable<Varchar>,
        #[max_length = 255]
        country -> Nullable<Varchar>,
    }
}

diesel::table! {
    office (id) {
        id -> Int4,
        company_id -> Int4,
    }
}

diesel::table! {
    payments (id) {
        id -> Int4,
        company_id -> Int4,
        currency_id -> Int4,
        amount -> Numeric,
    }
}

diesel::table! {
    permissions (id) {
        id -> Int4,
        description -> Nullable<Text>,
        #[max_length = 255]
        name -> Varchar,
    }
}

diesel::table! {
    role (id) {
        id -> Int4,
        #[max_length = 255]
        title -> Varchar,
        description -> Nullable<Text>,
    }
}

diesel::table! {
    role_permissions (id) {
        id -> Int4,
        permission_id -> Int4,
        role_id -> Int4,
    }
}

diesel::table! {
    role_user (id) {
        id -> Int4,
        role_id -> Int4,
        user_id -> Int4,
    }
}

diesel::table! {
    tax (id) {
        id -> Int4,
        account_id -> Int4,
        location_id -> Int4,
        tax_rate -> Numeric,
        tax_total -> Numeric,
    }
}

diesel::table! {
    tax_money (id) {
        id -> Int4,
        tax_id -> Int4,
        money_id -> Int4,
        #[max_length = 10]
        money_type -> Bpchar,
    }
}

diesel::table! {
    users (id) {
        id -> Int4,
        #[max_length = 255]
        email_address -> Varchar,
        #[max_length = 255]
        name -> Varchar,
    }
}

diesel::table! {
    vendor (id) {
        id -> Int4,
        #[max_length = 255]
        email -> Varchar,
        #[max_length = 20]
        phone_number -> Varchar,
    }
}

diesel::joinable!(account -> currency (currency_id));
diesel::joinable!(account_details -> account (account_id));
diesel::joinable!(account_invoice -> account (account_id));
diesel::joinable!(account_invoice -> invoice (invoice_id));
diesel::joinable!(account_payable -> currency (currency_id));
diesel::joinable!(account_payable_vendor -> account_payable (account_payable_id));
diesel::joinable!(account_payable_vendor -> vendor (vendor_id));
diesel::joinable!(account_receivable -> currency (currency_id));
diesel::joinable!(account_receivable_customer -> account_receivable (account_receivable_id));
diesel::joinable!(account_receivable_customer -> customers (customer_id));
diesel::joinable!(checks -> account (account_id));
diesel::joinable!(checks -> currency (currency_id));
diesel::joinable!(company_account -> account (account_id));
diesel::joinable!(company_account -> company (company_id));
diesel::joinable!(company_user -> company (company_id));
diesel::joinable!(company_user -> users (user_id));
diesel::joinable!(finance_period -> account (account_id));
diesel::joinable!(income -> company (company_id));
diesel::joinable!(income -> currency (currency_id));
diesel::joinable!(invoice -> currency (currency_id));
diesel::joinable!(invoice -> incoterms (incoterms_id));
diesel::joinable!(list_item -> invoice (invoice_id));
diesel::joinable!(location -> office (office_id));
diesel::joinable!(office -> company (company_id));
diesel::joinable!(payments -> company (company_id));
diesel::joinable!(payments -> currency (currency_id));
diesel::joinable!(role_permissions -> permissions (permission_id));
diesel::joinable!(role_permissions -> role (role_id));
diesel::joinable!(role_user -> role (role_id));
diesel::joinable!(role_user -> users (user_id));
diesel::joinable!(tax -> account (account_id));
diesel::joinable!(tax -> location (location_id));
diesel::joinable!(tax_money -> tax (tax_id));

diesel::allow_tables_to_appear_in_same_query!(
    account,
    account_details,
    account_invoice,
    account_payable,
    account_payable_vendor,
    account_receivable,
    account_receivable_customer,
    checks,
    company,
    company_account,
    company_user,
    currency,
    customers,
    finance_period,
    income,
    incoterms,
    invoice,
    list_item,
    location,
    office,
    payments,
    permissions,
    role,
    role_permissions,
    role_user,
    tax,
    tax_money,
    users,
    vendor,
);
