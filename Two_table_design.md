# Two Tables Design Recipe Template
​
_Copy this recipe template to design and create two related database tables from a specification._
​
## 1. Extract nouns from the user stories or specification
​
```
# (analyse only the relevant part - here the final line).
​
1)
As a user
so that i can use the website
I can sign up using my username, email address and password.
​
2)
As a user
So that i can list a place
I will be able to provide my spaces name, a short description and the price per night.
​
3)
As a user 
So that I can state when my place is available, 
I can state the availability of the place (start date and end date).
​
```
Nouns:
​
Username, email address, password, user
```
​
## 2. Infer the Table Name and Columns
​
Put the different nouns in this table. Replace the example with your own nouns.
​
| Record                | Properties          |
| --------------------- | ------------------  |
| Users                  |Username
                         |email_address
                         |password
                         |User_id
​
                        | 
| Properties            | Proprty_id
                        | Title
                        | Description
                        | Price_per_night
                        | User_id
​
1. Name of the first table (always plural):  
​
    Column names: Users
​
2. Name of the second table (always plural): 
​
    Column names: Properties
​
## 3. Decide the column types.
​
[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).
​
Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.
​
Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.
​
```
# EXAMPLE:
​
Table: users
id: SERIAL
username: text
email_address: text
password :text
​
Table: properties
id: SERIAL
title: text
description: text
price_per_night: int
user_id: int
```
​
## 4. Decide on The Tables Relationship
​
Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.
​
To decide on which one, answer these two questions:
​
1. Can one [User] have many [Properties]? (Yes)
2. Can one [Porperty] have many [Users]? (No)
​
You'll then be able to say that:
​
1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]
​
Replace the relevant bits in this example with your own:
​
```
# EXAMPLE
​
1. Can one user have many properties? YES
2. Can one property have many users? NO
​
-> Therefore,
-> An user HAS MANY properties
-> An property BELONGS TO an user
​
-> Therefore, the foreign key is on the properties table.
```
​
*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*
​
## 4. Write the SQL.
​
```sql
-- file: properties_table.sql
​
-- Replace the table name, columm names and types.
​
-- Create the table without the foreign key first.
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username text,
  email_address text,
  password text
);
​
-- Then the table with the foreign key first.
CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  title text,
  description text,
  price_per_night int,
-- The foreign key name is always {user}_id
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);
​
```
​
## 5. Create the tables.
​
```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```
​
<!-- BEGIN GENERATED SECTION DO NOT EDIT -->