require "spec_helper"
require 'property'
require 'property_repository'

def reset_property_table
  seed_sql = File.read('spec/seeds/properties_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'makersbnb_test' })
  connection.exec(seed_sql)
end

describe PropertyRepository do

  before(:each) do
    reset_property_table
  end
  after(:each) do
    reset_property_table
  end

  context "When call method all" do
    it '#finds all properties' do
      repo = PropertyRepository.new

      properties = repo.all

      expect(properties.length).to eq(2)

      expect(properties.first.id).to eq(1)
      expect(properties.first.title).to eq('Semi detached 2 bedroom house')
      expect(properties.first.description).to eq('Amazing for the weekend')
      expect(properties.first.price_per_night).to eq(45)
      expect(properties.first.start_date).to eq ('2022-09-10')
      expect(properties.first.end_date).to eq ('2022-09-20')
      expect(properties.first.user_id).to eq(2)

      expect(properties[1].id).to eq(2)
      expect(properties[1].title).to eq('Tiny home')
      expect(properties[1].description).to eq('Escape to a Romantic and Magical Hobbit Retreat')
      expect(properties[1].price_per_night).to eq(90)
      expect(properties[1].start_date).to eq ('2022-09-21')
      expect(properties[1].end_date).to eq ('2022-09-30')
      expect(properties[1].user_id).to eq(1)

    end
  end

  context "When call method find" do
    it '#finds a specific property with passing the id value' do
      repo = PropertyRepository.new

      property = repo.find(1)

      expect(property.id).to eq(1)
      expect(property.title).to eq('Semi detached 2 bedroom house')
      expect(property.description).to eq('Amazing for the weekend')
      expect(property.price_per_night).to eq(45)
      expect(property.user_id).to eq(2)
    end
  end

  context "When creating a new property" do
    it "#adds a property to the database" do
        repo = PropertyRepository.new
        new_property = Property.new
        new_property.title = 'Highbury Square'
        new_property.description = 'Stay at the old Arsenal Stadium'
        new_property.price_per_night = 120
        new_property.start_date ='2022-10-02'
        new_property.end_date = '2022-10-09'
        new_property.user_id = 1
        repo.create(new_property)
        properties = repo.all
        expect(properties.length).to eq (3)
        expect(properties.last.title).to eq ('Highbury Square')
    end
  end

end
