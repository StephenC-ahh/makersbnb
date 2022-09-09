require_relative "users.rb"

class UserRepository
    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      # SELECT id, username, email_address, password FROM users;
      sql = 'SELECT id, username, email_address, password FROM users;'
      result_set = DatabaseConnection.exec_params(sql, [])
 
      users = []
 
      result_set.each do |record|
         user = User.new
 
         user.id = record['id'].to_i
         user.username = record['username']
         user.email_address = record['email_address']
         user.password = record['password']
         users << user
 
      end
 
      return users
  
      # Returns an array of User objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      # SELECT id, username, email_address, password FROM users; WHERE id = $1;
      sql = 'SELECT id, username, email_address, password FROM users WHERE id = $1;'

      params = [id]

      result = DatabaseConnection.exec_params(sql, params)

      record = result[0]
      user = User.new

      user.id = record['id'].to_i
      user.username = record['username']
      user.email_address = record['email_address']
      user.password = record['password']

      return user
  
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
      sql = 'INSERT INTO users (username, email_address, password)  VALUES ($1, $2, $3);'
      sql_params = [user.username, user.email_address, user.password]

      DatabaseConnection.exec_params(sql, sql_params)

      return nil
  
      # Returns nothing
    end
  
  
    # update a user record 
    # given a User object with updated attributes
    def update(user)
      # Executes the SQL query:
      # UPDATE users  
      #    SET username = $1, email_address = $2, password = $3
      #    WHERE id = $4;

      sql = 'UPDATE users SET username = $1, email_address = $2, password = $3 WHERE id = $4;'
      sql_params = [user.username, user.email_address, user.password, user.id]

      DatabaseConnection.exec_params(sql, sql_params)

      return nil
  
      # returns nothing
    end
  
    # delete a user record
    # given its id
    def delete(id)
      # Executes the SQL query:
      # DELETE FROM users WHERE id = $1;

      sql = 'DELETE FROM users WHERE id = $1;'
      sql_params = [id]

      DatabaseConnection.exec_params(sql, sql_params)

      return nil
  
      # return nothing
    end

    def sign_in(email_address, submitted_password)
      user = find_by_email(email_address)
  
      return nil if user.nil?
  
      if user.password == submitted_password
        # login success
        return user
      else
        return false
        # wrong password
      end
    end

    def find_by_email(email_address)
      sql = "SELECT * FROM users WHERE email_address = $1"

      params = [email_address]

      result = DatabaseConnection.exec_params(sql, params)

      user = User.new

      result.each do |record|

        user.id = record['id'].to_i
        user.username = record['username']
        user.email_address = record['email_address']
        user.password = record['password']
      end

      if user.username == nil
        return nil 
      end

      return user
    end

    def find_by_username(username)
      sql = "SELECT * FROM users WHERE username = $1"
      params = [username]
      result = DatabaseConnection.exec_params(sql, params)
      user = User.new
      result.each do |record|
        user.username = record['username']
      end
      if user.username == nil
        return false 
      else
        return true
      end
    end

    def register(user)
      email_exists = find_by_email(user.email_address) != nil
      if email_exists 
        return "E-mail already registered"
      end
      username_exists = find_by_username(user.username)
      if username_exists
        return "Username is already taken"
      else
        create(user)
        return "You have successfully registered!"
      end
    end

end