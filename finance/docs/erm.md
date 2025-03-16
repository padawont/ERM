```Mermaid
erDiagram


company ||--o{ office :""
office ||--|| location:""
company ||--o{ company_user :""
company_user ||--o{ user :""
user ||--o{ role_user :""
role_user ||--o{ role :""
role_permisstions ||--o{ role : ""
role_permisstions ||--o{ permisstions :""
invoice ||--|| list_item : ""
invoice ||--|| incoterms : ""
invoice ||--|| currency : ""
account ||--|| finace_period : ""
company ||--o{ company_account : ""
company_account ||--o{ account :""
account ||--||  account_details :""
company_account ||--o{ account_Receivable : "" 
company_account ||--o{ account_payable : ""
account_payable ||--o{ account_payable_vendor : ""
account_payable_vendor ||--o{ vendor : ""
account_Receivable ||--o{ account_Receivable_customer : ""
account_Receivable_customer ||--o{ customers : ""
account_payable ||--o{ account_invoice : ""
account_Receivable ||--o{ account_invoice : ""
account_invoice ||--o{ invoice : ""
currency ||--|| account_payable : ""
currency ||--|| account_Receivable: ""
currency ||--|| account : ""
account ||--o{ tax : ""
account_payable ||--o{ tax : ""
account_Receivable ||--o{ tax : ""
tax ||--o{ tax_money : ""
tax_money ||--o{ checks : ""
tax_money ||--o{ payments : ""
tax_money ||--o{ invoice : ""
tax_money ||--o{ income : ""
currency ||--|| checks : ""
currency ||--|| payments : ""
currency ||--|| income : ""




company {
    Int id PK
    string email_address
    string name
    date timestamp
} 


office {
    int id PK 
    int company FK
}

location {
    int id PK 
    int office_id FK
    string adddress 
    string city 
    string country 
}



income {
    int id PK
    int company_id FK
    int currency_id FK
    int amount 
}


company_user {
    Int id PK 
    Int user_id FK
    Int company_id FK
    
}


user {
    Int id PK
    string email_address
    string name 
}

role_user {
    Int id PK
    Int role_id FK
    Int user_id FK
}

role {
    Int id PK
    string title
    string desrciption
} 


role_permisstions {
    Int id PK
    Int permisstions_id FK
    Int role_id FK
} 

permisstions {
    Int id PK
    string desrciption
    string name

}




company_account {
    int id PK
    int company_id FK
    int account_id FK 
}



account_payable {
    int id PK
    int currency_id FK
    Date due_date
    enum status
    float amount
    string terms
}



account_invoice {
    int id PK
    int account_id FK
    int invoice FK
    bool account_is_payable
}

account_payable_vendor {
    int id PK
    int account_payable FK
    int vendor FK
}


account_Receivable {
    int id PK
    int currency FK
    Date due_date 
    enum status
    string terms
    float amount 
}

account_Receivable_customer {
    int id PK
    int account_Receivable FK
    int customer FK
}


account {
    Int id PK
    int currency FK
    decimal credit
    decimal debit  
    enum account_type 
}
account_details {
    Int id PK 
    Int acount FK 
    string Bank_name 
    string Branch_name 
    string swift_code
    string ifsc_code 
    int routing_number
    string IBAN 
    string bank_website 
}





tax {
    Int id PK
    Int account FK
    int location FK
    int tax_rate 
    int tax_total
}


tax_money {
    int id PK
    int tax_id
    int money_id 
    enum type
}


customers {
    Int id PK 
    Int number 
    string email 
}

checks {
    int id PK 
    int account FK 
    int currency_id FK
    int amount 
}


payments {
    int id PK
    int company_id FK
    int currency_id FK 
    int amount 
}



invoice {
    Int id PK
    int invoice_number
    Date starting_date
    Date ending_date 
    string sender_info 
    float subtotal
    string payment_instruections 
    string notes
    int currency_id FK
    string incoterms FK
}

list_item {
    int id PK
    int quantitiy
    string description
    float unit_price
    float total
}

incoterms {
    int id PK
    string name
    string description
}

finace_period {
    int id PK
    int account FK
    Date start_date
    Date end_date 
    enum status
} 

currency  {
    int id PK
    string currency_name
    int currency_code
    string country 
    decimal exchange_rate
}
vendor {
    int id PK 
    string email 
    int number
}



```
