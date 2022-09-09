# GET/properties Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

  Method : Get
  Path: /properties
  Query/ Body parameters?: No
## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```ruby
'Semi detached 2 bedroom house'
'Amazing for the weekend'
45

'Tiny home'
'Escape to a Romantic and Magical Hobbit Retreat'
 90
```

## 3. Write Examples

_Replace these with your own design._

```
# Request:

GET /properties

# Expected response:

Response for 200 OK

```
'Semi detached 2 bedroom house'
'Amazing for the weekend'
45

'Tiny home'
'Escape to a Romantic and Magical Hobbit Retreat'
90
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /properties" do
    it 'returns 200 OK' do
      response = get('/properties')

      expect(response.status).to eq(200)
      expect(response.body).to include('Amazing for the weekend')
      expect(response.body).to include('Escape to a Romantic and Magical Hobbit Retreat')
    end

    it 'returns 404 Not Found' do
      response = get('/listing')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
