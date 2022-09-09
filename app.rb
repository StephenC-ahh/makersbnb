require 'sinatra/base'
require 'sinatra/reloader'
require_relative 'lib/database_connection'
require_relative 'lib/property_repository'
require_relative 'lib/users_repository'
require_relative 'lib/property'
require_relative 'lib/users'

class Application < Sinatra::Base
    # This allows the app code to refresh
    # without having to restart the server.
    configure :development do
        register Sinatra::Reloader
        also_reload 'lib/property_repository'
        also_reload 'lib/users_repository'
        enable :sessions #This enables the cookie session
    end

    #Home page
    get '/' do
        return erb(:index, { :locals => params, :layout => :the_layout_project })
    end


    # We need to give the database name to the method `connect`
    DatabaseConnection.connect('makersbnb_test')

    #Register Page
    get '/register' do
        if session[:user]==nil
          #return erb(:'registration/register_page')
          return erb(:'registration/register_page', { :locals => params, :layout => :the_layout_project })
        end
        redirect "/properties"
    end

    #Register a new user
    post '/register' do
        repo = UserRepository.new
        user = User.new

        user.username = params[:username]
        user.email_address = params[:email_address]
        user.password = params[:password]

        result = repo.register(user)
        session[:register_message] = result
        if result == "You have successfully registered!"
          session[:user] = repo.find_by_email(user.email_address)
        end

        #return erb(:"registration/registration_successful")
        return erb(:'registration/registration_result', { :locals => params, :layout => :the_layout_project })
    end

    #Login Page
    get '/login' do
      if session[:user]==nil
        #return erb(:'login/login')
        return erb(:'login/login', { :locals => params, :layout => :the_layout_project })
      end
      redirect "/properties"
    end

    #Login as a User
    post '/login' do
      repo = UserRepository.new

      email_address = params[:email_address]
      password = params[:password]
      user = repo.sign_in(email_address, password)
      case 
        user
      when nil
        session[:login_message] = "Account does not exist"
      when false
        session[:login_message] = "Incorrect password"
      else
        session[:login_message] = "You have logged in!"
        session[:user] = user
      end

      return erb(:'login/login_result', { :locals => params, :layout => :the_layout_project })

    end

    get '/logout' do
      session[:user] = nil
      redirect '/login'
    end















































    #Properties Listed on a webpage
    get '/properties' do
      repo = PropertyRepository.new
      @properties = repo.all
      return erb(:'properties/properties', { :locals => params, :layout => :the_layout_project })
      #return erb(:'properties/properties')
    end

    

    #Add a property
    get '/properties/new' do
      #return erb(:'properties/new_property')
      return erb(:'properties/new_property', { :locals => params, :layout => :the_layout_project })
    end

    #Find properties by ID
    get '/properties/:id' do
      @find_properties = PropertyRepository.new.find(params[:id])
      #return erb(:'properties/property_info')
      return erb(:'properties/property_info', { :locals => params, :layout => :the_layout_project })
    end

    #Adds a new property and takes you to its listing
    post '/property' do
      repo = PropertyRepository.new
      new_property = Property.new
      new_property.title = params[:title]
      new_property.description = params[:description]
      new_property.price_per_night = params[:price_per_night]
      new_property.start_date = params[:start_date]
      new_property.end_date = params[:end_date]
      #adding user_id to a new listing from session
      new_property.user_id = session[:user].id
      repo.create(new_property)
      @find_properties = repo.find(repo.all[-1].id)
      #return erb(:'properties/property_info')
      return erb(:'properties/property_info', { :locals => params, :layout => :the_layout_project })
    end
  end

