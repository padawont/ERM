use diesel::prelude::*;
use diesel::Queryable;
use diesel::Insertable;
use diesel::sql_types::{BigInt, Integer, Text}; // Import Diesel SQL types
use chrono::NaiveDate;

// Import the schema for table references
use crate::schema::*;

// Example for `users` table
#[derive(Queryable, Debug)]
pub struct User {
    pub id: i32,
    pub email_address: String,
    pub name: String,
}

#[derive(Insertable)]
#[diesel(table_name = users)]
pub struct NewUser<'a> {
    pub email_address: &'a str,
    pub name: &'a str,
}

// Account table
#[derive(Queryable, Debug)]
pub struct Account {
    pub id: i32,
    pub currency_id: i32,
    pub credit: i64, // Represented as BIGINT in the database
    pub debit: i64,  // Represented as BIGINT in the database
    pub account_type: String,
}
#[derive(Insertable)]
#[diesel(table_name = account)]
pub struct NewAccount<'a> {
    #[diesel(sql_type = Integer)]
    pub currency_id: i32,

    #[diesel(sql_type = BigInt)]
    pub credit: i64,

    #[diesel(sql_type = BigInt)]
    pub debit: i64,

    #[diesel(sql_type = Text)]
    pub account_type: &'a str,
}


// AccountDetails table
#[derive(Queryable, Debug)]
pub struct AccountDetails {
    pub id: i32,
    pub account_id: i32,
    pub bank_name: Option<String>,
    pub branch_name: Option<String>,
    pub swift_code: Option<String>,
    pub ifsc_code: Option<String>,
    pub routing_number: Option<String>,
    pub iban: Option<String>,
    pub bank_website: Option<String>,
}

#[derive(Insertable)]
#[diesel(table_name = account_details)]
pub struct NewAccountDetails<'a> {
    pub account_id: i32,
    pub bank_name: Option<&'a str>,
    pub branch_name: Option<&'a str>,
    pub swift_code: Option<&'a str>,
    pub ifsc_code: Option<&'a str>,
    pub routing_number: Option<&'a str>,
    pub iban: Option<&'a str>,
    pub bank_website: Option<&'a str>,
}

// Company table
#[derive(Queryable, Debug)]
pub struct Company {
    pub id: i32,
    pub email_address: Option<String>,
    pub name: String,
    pub timestamp: Option<NaiveDate>,
}

#[derive(Insertable)]
#[diesel(table_name = company)]
pub struct NewCompany<'a> {
    pub email_address: Option<&'a str>,
    pub name: &'a str,
    pub timestamp: Option<NaiveDate>,
}

// Continue for other tables...
