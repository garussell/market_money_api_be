# MOD3 - Market Money
### Allen Russell

#### Overview

Market Money is an API designed to help users find sustainable and local alternatives in their area. The API provides various endpoints that allow users to search for markets, vendors, and more. It incorporates testing, error handling, SQL/AR, and integration with the [TomTom API](https://developer.tomtom.com/).

#### Table of Contents
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Testing](#testing)
- [Contributing](#contributing)

#### Technologies Used
- Ruby 3.2.2
- Rails 7.0.7.2
- Faraday gem for API requests
- JSONAPI Serializer gem for formatting JSON responses
- Faker gem for generating fake data
- SimpleCov gem for code coverage tracking
- Shoulda Matchers gem for testing assertions

#### Installation
1. Clone the repository to your local machine.
2. Navigate to the project directory: cd market_money.
3. Install the required gems: bundle install.
4. Set up the database: rails db:setup.
5. Start the Rails server: rails server.

#### Usage
1. Make requests to the API endpoints using tools like Postman.
2. Download the Market Money Test Suite in the [Testing](#testing) section and import into Postman as a "collection".
3. Refer to the API Endpoints section for available routes and their descriptions.

#### API Endpoints
1. `GET /api/v0/markets` - Retrieve ALL markets in the database.
2. `GET /api/v0/markets/:id` - Retrieve a market by ID.
3. `GET /api/v0/markets/:id/vendors` - Retrieve ALL vendors for a market
4. `GET /api/v0/vendors/:id` - Get one vendor by ID.
5. `POST /api/v0/vendors` - Create a vendor.
6. `PATCH /api/v0/vendors/:id` - Update a vendor.
7. `DELETE /api/v0/vendors/:id` - Delete a vendor.
8. `POST /api/v0/market_vendors` - Create a MarketVendor association.
9. `DELETE /api/v0/market_vendors` - Delete a MarketVendor association.
10. `GET /api/v0/markets/search` - Search markets by state, city, and/or name.
11. `GET /api/v0/markets/:id/nearest_atms` - Get cash dispenser near a market by market_id.

#### Testing
1. Import the provided Postman test suite: [Market Money Test Suite](https://backend.turing.edu/module3/projects/market_money/market_money.postman_collection.json)
2. Use the test suite to validate API responses and functionality.
3. Ensure that all tests in the Postman suite pass successfully.
4. Use SimpleCov to track code coverage: open coverage/index.html.

#### Contributing
If you'd like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix: git checkout -b my-feature.
3. Commit your changes: git commit -am 'Add new feature'.
4. Push the branch to your fork: git push origin my-feature.
5. Create a pull request outlining your changes.

[Back to the Top](#mod3---market-money)