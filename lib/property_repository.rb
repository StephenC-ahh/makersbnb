require_relative 'property.rb'

class PropertyRepository

    def all
        properties = []
        sql = "SELECT id, title, description, price_per_night, start_date, end_date, user_id FROM properties"
        result = DatabaseConnection.exec_params(sql, [])
        result.each do |property|
            new_property = Property.new
            new_property.id = property["id"].to_i
            new_property.title = property["title"]
            new_property.description = property["description"]
            new_property.price_per_night = property["price_per_night"].to_i
            new_property.start_date = property["start_date"]
            new_property.end_date = property["end_date"]
            new_property.user_id = property["user_id"].to_i
            properties << new_property
        end
        return properties
    end

    def find(id)
        sql = 'SELECT id, title, description, price_per_night, start_date, end_date, user_id FROM properties WHERE id = $1;'
        result_set = DatabaseConnection.exec_params(sql, [id])
    
        property = Property.new
        property.id = result_set[0]['id'].to_i
        property.title = result_set[0]['title']
        property.description = result_set[0]['description']
        property.price_per_night = result_set[0]['price_per_night'].to_i
        property.user_id = result_set[0]['user_id'].to_i
        property.start_date = result_set[0]['start_date']
        property.end_date = result_set[0]['end_date']
        return property
      end

      def create(property)
        sql = 'INSERT INTO properties (title, description, price_per_night, start_date, end_date, user_id) VALUES ($1, $2, $3, $4, $5, $6);'
        DatabaseConnection.exec_params(sql, [property.title, property.description, property.price_per_night, property.start_date, property.end_date, property.user_id])
        return property
      end


# INSERT INTO properties (title, description, price_per_night, user_id)
# SELECT property_availability.start_date, property_availability.end_date FROM property_availability;


    # def 
    # sql = ' SELECT properties.title, properties.description, property_availability.start_date, property_availability.end_date
    # FROM properties
    # JOIN property_availability
    # ON properties.id = property_availability.property_id;'
    # end
end