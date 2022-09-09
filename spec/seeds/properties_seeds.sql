-- Write your SQL seed here.
DROP TABLE IF EXISTS properties;
DROP TABLE IF EXISTS users;
-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username text,
  email_address text,
  password text
);

CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  title text,
  description text,
  price_per_night int,
  start_date DATE,
  end_date DATE,
-- The foreign key name is always {user}_id
  user_id int,
  constraint fk_user foreign key(user_id)
    references users(id)
    on delete cascade
);

TRUNCATE TABLE users, properties RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

-- Our albums table has reference to a foreign key ('artist_id')
-- because of that we do line 40 and line 49, user_id
INSERT INTO users(username, email_address, password) VALUES ('Jack', 'JackJones@gmail.com', 'SkyBlue123');
INSERT INTO users(username, email_address, password) VALUES ('test', 'test@test.com', '1234');

INSERT INTO properties (title, description, price_per_night,start_date, end_date, user_id) VALUES ('Semi detached 2 bedroom house', 'Amazing for the weekend', 45, '2022/09/10', '2022/09/20', 2);
INSERT INTO properties (title, description, price_per_night,start_date, end_date, user_id) VALUES ('Tiny home','Escape to a Romantic and Magical Hobbit Retreat', 90, '2022/09/21', '2022/09/30', 1);