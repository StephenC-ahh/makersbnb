# User Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `users`*

```
# EXAMPLE

Table: users
Columns:
id | username | email_address | password

```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO users (username, email_address, password) VALUES ('Jack', 'JackJones@gmail.com', 'SkyBlue123');
INSERT INTO users (username, email_address, password) VALUES ('Skye', 'Skyhatesthis@ooutlook.com', 'Catperson339');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 makersbnb_test < users_seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# Table name: users
# Model class
class User
end

# Repository class
class UserRepository
end

```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# Table name: users
class User

  # Replace the attributes by your own columns.
  attr_accessor :id, :username, :email_address, :password
end

```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: users
class UserRepository
  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, username, email_address, password FROM users;

    # Returns an array of User objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, username, email_address, password FROM users; WHERE id = $1;

    # Returns a single User object.
  end

  # Add more methods below for each operation you'd like to implement.

  # Create a single users record
  # Given a single User object
  def create(user)
    # Executes the SQL query:
    # INSERT INTO
    #   users (username, email_address, password)
    #   VALUES ($1, $2, $3);

    # Returns nothing
  end


  # update a user record 
  # given a User object with updated attributes
  def update(user)
    # Executes the SQL query:
    # UPDATE users  
    #    SET username = $1, email_address = $2, password = $3
    #    WHERE id = $4;

    # returns nothing
  end

  # delete a user record
  # given its id
  def delete(id)
    # Executes the SQL query:
    # DELETE FROM users WHERE id = $1;

    # return nothing
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby

# Users Repo
# 1
# Get all users

repo = UserRepository.new

users = repo.all

users.length # =>  2

users[0].id # =>  1
users[0].username # =>  'Jack'
users[0].email_address # =>  'JackJones@gmail.com'
users[0].password # => 'SkyBlue123'

users[1].id # =>  2
users[1].username # =>  'Skye'
users[1].email_address # =>  'Skyhatesthis@ooutlook.com'
users[1].password # => 'Catperson339'


# 2
# Get a single users

repo = UserRepository.new

users = repo.find(1)

users.id # =>  1
users.userrname # =>  'Jack'
users.email_address # =>  'JackJones@gmail.com'
users.password # =>  'SkyBlue123'

# 3
# can create a single user record

repo = UserRepository.new

new_user = User.new
new_user.email_address = 'roi@gmail.com'
new_user.username = 'roi'
new_user.password = 'password123'

repo.create(new_user)

all_users = repo.all

all_users.length # => 3

all_users.last.id # =>  3
all_users.last.username # =>  'roi'
all_users.last.email_address # =>  'roi@gmail.com'
all_users.last.password # => 'password123'

# 4
# update a single user record

repo = UserRepository.new

user2 = repo.find(2)

user2.email_address = 'changed@gmail.com'
user2.username = 'changed'
user2.password = 'change123'

repo.update(user2)

updated_user2 = repo.find(2)

updated_user2.username # => 'changed'
update_user2.email_address # => 'changed@gmail.com'
update_user2.password # => 'change123'


# 5
# deletes a single user record

repo = UserRepository.new

repo.delete(2)

all_users =  repo.all

all_users.length # => 1

all_users[0].id # =>  1
all_users[0].username # =>  'Jack'
all_users[0].email_address # =>  'JackJones@gmail.com'
all_users[0].password # => 'SkyBlue123'


```

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/users_repository_spec.rb

def reset_makersbnb_test
  seed_sql = File.read('spec/users_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe UserRepository do
  before(:each) do 
    reset_makersbnb_test
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._