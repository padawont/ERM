```Mermaid
flowchart TB
    subgraph "PRIMARY ENTITIES"
        subgraph "Core Business Entities"
            company
            users
            customers
            vendor
        end
        
        subgraph "Reference Entities"
            currency
            incoterms
        end
        
        subgraph "Authorization Entities"
            permissions
            role
        end
    end
    
    subgraph "ACCOUNT ENTITIES"
        subgraph "Core Account"
            account
            account_details
            finance_period
        end
        
        subgraph "Accounts Payable/Receivable"
            account_payable
            account_payable_vendor
            account_receivable
            account_receivable_customer
        end
    end
    
    subgraph "FINANCIAL ENTITIES"
        subgraph "Transaction Records"
            checks
            income
            payments
        end
        
        subgraph "Invoicing"
            invoice
            list_item
        end
        
        subgraph "Taxation"
            tax
            tax_money
        end
    end
    
    subgraph "RELATIONSHIP ENTITIES"
        subgraph "Company Relationships"
            company_account
            company_user
            office
            location
        end
        
        subgraph "User Relationships"
            role_permissions
            role_user
        end
        
        subgraph "Financial Relationships"
            account_invoice
        end
    end
```