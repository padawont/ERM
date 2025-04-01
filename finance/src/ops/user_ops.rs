use crate::models::{NewUser, User};
use crate::db::establish_connections;
use diesel::prelude::*;

pub fn create_user(user:NewUser) {
    println!("creating a new user");
    use crate::schema::videos::dsl::*;
    let connection = establish_connections();
   
   
    let new_user{
        email: &user.
        
    };
}