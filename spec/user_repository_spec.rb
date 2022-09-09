require 'users_repository.rb'
require 'users.rb'

def reset_makersbnb_test
    seed_sql = File.read('spec/seeds/properties_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
    connection.exec(seed_sql)
end

RSpec.describe UserRepository do

    before(:each) do
      reset_makersbnb_test
    end
    after(:each) do
        reset_makersbnb_test
      end

  context '#list all users' do
    it "returns a list of all users" do
        repo = UserRepository.new

        users = repo.all

        expect(users.length).to eq 2

        expect(users[0].id).to eq 1
        expect(users[0].username).to eq 'Jack'
        expect(users[0].email_address).to eq 'JackJones@gmail.com'
        expect(users[0].password).to eq 'SkyBlue123'

        expect(users[1].id).to eq 2
        expect(users[1].username).to eq 'test'
        expect(users[1].email_address).to eq 'test@test.com'
        expect(users[1].password).to eq '1234'
        end
    end

    context '#find a given user' do
        it "finds a user record" do
            repo = UserRepository.new

            users = repo.find(1)

            expect(users.id).to eq 1
            expect(users.username).to eq 'Jack'
            expect(users.email_address).to eq 'JackJones@gmail.com'
            expect(users.password).to eq 'SkyBlue123'
        end
    end

    context '#create a single user' do
        it "adds a new user record" do
            repo = UserRepository.new

            new_user = User.new

            new_user.username = 'roi'
            new_user.email_address = 'roi@gmail.com'
            new_user.password = 'password123'

            repo.create(new_user)

            all_users = repo.all

            expect(all_users.length).to eq 3

            expect(all_users.last.id).to eq  3
            expect(all_users.last.username).to eq  'roi'
            expect(all_users.last.email_address).to eq  'roi@gmail.com'
            expect(all_users.last.password).to eq 'password123'
        end
    end

    context '#updates a given user' do
        it "updates a user record" do
            repo = UserRepository.new

            user2 = repo.find(2)

            user2.email_address = 'changed@gmail.com'
            user2.username = 'changed'
            user2.password = 'change123'

            repo.update(user2)

            updated_user2 = repo.find(2)

            expect(updated_user2.username).to eq 'changed'
            expect(updated_user2.email_address).to eq 'changed@gmail.com'
            expect(updated_user2.password).to eq 'change123'
        end
    end

    context '#delete a user' do
        it "deletes a user record" do
            repo = UserRepository.new

            repo.delete(2)

            all_users =  repo.all

            expect(all_users.length).to eq 1

            expect(all_users[0].id).to eq  1
            expect(all_users[0].username).to eq  'Jack'
            expect(all_users[0].email_address).to eq  'JackJones@gmail.com'
            expect(all_users[0].password).to eq 'SkyBlue123'
        end
    end

    context '#find_by_email' do 
        it "find user using email address" do 
            repo = UserRepository.new 

            user = repo.find_by_email('JackJones@gmail.com')

            expect(user.id).to eq 1
            expect(user.username).to eq 'Jack'
            expect(user.password).to eq 'SkyBlue123'
        end
    end

    context '#sign_in' do 
        it 'signs in successfully and returns a user object' do 
            repo = UserRepository.new 

            user = repo.sign_in('JackJones@gmail.com','SkyBlue123')

            expect(user.id).to eq 1
            expect(user.username).to eq 'Jack'
        end

        it ' returns null if email not in database' do 
            repo = UserRepository.new 

            user = repo.sign_in('Jack@gmail.com','Skye123')

            expect(user).to eq nil
        end

        it 'returns false is password is incorrect' do 
            repo = UserRepository.new 

            user = repo.sign_in('JackJones@gmail.com','Skye123')

            expect(user).to eq false
        end
    end

    context 'When checking that a user exists' do
        it "#returns true if the user exists" do
            repo = UserRepository.new
            result = repo.find_by_username('Jack')
            expect(result).to eq true
        end
        it "#returns false if the user doesn't exists" do
            repo = UserRepository.new
            result = repo.find_by_username('Jacob')
            expect(result).to eq false
        end
    end

    context "When registering a new user" do
        it "#returns You have successfully registered! if there is no other user with the same details" do
            repo = UserRepository.new
            new_user = User.new
            new_user.username = 'Malena Gracia'
            new_user.email_address = 'malenagracia@gmail.com'
            new_user.password = '1234'

            result = repo.register(new_user)

            all_users = repo.all

            expect(all_users.length).to eq 3

            expect(all_users.last.id).to eq  3
            expect(all_users.last.username).to eq  'Malena Gracia'
            expect(all_users.last.email_address).to eq  'malenagracia@gmail.com'
            expect(all_users.last.password).to eq '1234'

            expect(result).to eq "You have successfully registered!"
        end

        it "#returns can't register the new user if username already exists" do
            repo = UserRepository.new
            new_user = User.new
            new_user.username = 'Jack'
            new_user.email_address = 'jackgracia@gmail.com'
            new_user.password = '1234'

            result = repo.register(new_user)

            all_users = repo.all

            expect(result).to eq "Username is already taken"

        end 

        it "#returns can't register the new user if email address is already in use" do
            repo = UserRepository.new
            new_user = User.new
            new_user.username = 'Jacob'
            new_user.email_address = 'JackJones@gmail.com'
            new_user.password = 'SkyBlu3'

            result = repo.register(new_user)

            all_users = repo.all

            expect(result).to eq "E-mail already registered"
        end
    end

end


        