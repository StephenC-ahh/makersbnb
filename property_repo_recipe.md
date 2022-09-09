{{TABLE NAME}} Model and Repository Classes Design Recipe
Copy this recipe template to design and implement Model and Repository classes for a database table.

1. Design and create the Table

# Table: properties

Columns:
id | title | description | price_per_night | user_id

2. Create Test SQL seeds

spec/properties_seeds.sql

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
INSERT INTO users (username, email_address, password) VALUES ('Skye', 'Skyhatesthis@ooutlook.com', 'Catperson339');

INSERT INTO properties (title, description, price_per_night, user_id) VALUES ('Semi detached 2 bedroom house', 'Amazing for the weekend', 45, '2');
INSERT INTO properties (title, description, price_per_night, user_id) VALUES ('Tiny home','Escape to a Romantic and Magical Hobbit Retreat', 90, '1');

psql -h 127.0.0.1 your_database_name < properties_seeds.sql

3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

# EXAMPLE
# Table name: properties

# Model class
# (in lib/properties.rb)
class Property
end

# Repository class
# (in lib/student_repository.rb)
class PropertyRepository
end

4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

# EXAMPLE
# Table name: properties

# Model class
# (in lib/property.rb)

class Property

  # Replace the attributes by your own columns.
  attr_accessor :title, :description, :price_per_night, :user_id
end


5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

# EXAMPLE
# Table name: properties

# Repository class
# (in lib/properties_repository.rb)

class StudentRepository

  # Selecting all properties
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, description, price_per_night, user_id FROM students;

    # Returns an array of Property objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, description, price_per_night, user_id FROM students WHERE id = $1;

    # Returns a single Property object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(property)
      # Executes the SQL query:
        # INSERT INTO properties (title, description, price_per_night, user_id) VALUES ('Highbury Square', 'Stay at the old Arsenal Stadium', 120, 1);

        # Adds a property to the properties table in the database.
  # end

--- NICE TO HAVE NOT MVP 
  # def update(property)
  # end

  # def delete(property)
  # end

end

6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

# EXAMPLES

# 1
# Get all students

repo = PropertyRepository.new

properties = repo.all

properties.length # =>  2

properties[0].id # =>  1
properties[0].title # =>  'Semi detached 2 bedroom house'
properties[0].description # =>  'Amazing for the weekend'
properties[0].price_per_night # =>  45
properties[0].user_id # =>  '2'

properties[1].id # =>  2
properties[1].title # =>  'Tiny home'
properties[1].description # =>  'Escape to a Romantic and Magical Hobbit Retreat'
properties[1].price_per_night # =>  90
properties[1].user_id # =>  '1'

# 2
# Get a single property

repo = PropertyRepository.new

property = repo.find(1)

property.id # =>  1
property.title # =>  'Semi detached 2 bedroom house'
property.description # =>  'Amazing for the weekend'
property.price_per_night # =>  45
property.user_id # =>  '2'

# Add more examples for each method
Encode this example as a test.

7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.