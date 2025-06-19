A Ballerina-based REST service for managing users with a MySQL backend.
Provides CRUD (Create, Read, Update, Delete) operations and supports bulk operations and fuzzy search.

Features
    Create Users (Bulk Insert): Add one or more users in a single request.
    Get User: Retrieve a user by their unique ID.
    Search Users: List all users or search by name/email.
    Update User: Modify user details by ID.
    Delete User: Remove a user by ID.

Prerequisites
    Ballerina (2201.12.6 or later)
    MySQL Server (5.7 or later)

Project Structure

 ├── Ballerina.toml
 ├── Config.toml
 ├── service.bal
 ├── resources/
 │   └── database/
 │       └── userdb1.sql
 └── modules/
     └── database/
         ├── types.bal
         ├── client.bal
         ├── db_queries.bal
         └── db_functions.bal


Example Usage
Create Users

bash
curl -X POST "http://localhost:8080/users" \
  -H "Content-Type: application/json" \
  -d '[{
        "id": 0,
        "firstName": "Ada",
        "lastName": "Lovelace",
        "email": "ada@example.com",
        "role": "engineer",
        "createdOn": "",
        "updatedOn": ""
      },
      {
        "id": 0,
        "firstName": "Grace",
        "lastName": "Hopper",
        "email": "grace@example.com",
        "role": "admiral",
        "createdOn": "",
        "updatedOn": ""
      }]'
List/Search Users

bash
curl "http://localhost:8080/users"
curl "http://localhost:8080/users?name=Ada"
Get User by ID

bash
curl "http://localhost:8080/users/1"
Update User

bash
curl -X PUT "http://localhost:8080/users/1" \
  -H "Content-Type: application/json" \
  -d '{
        "id": 1,
        "firstName": "Ada",
        "lastName": "Lovelace",
        "email": "ada@example.com",
        "role": "chief engineer",
        "createdOn": "",
        "updatedOn": ""
      }'
Delete User

bash
curl -X DELETE "http://localhost:8080/users/1"
OpenAPI Documentation
Generate an OpenAPI specification for your API:


Enjoy building with Ballerina!