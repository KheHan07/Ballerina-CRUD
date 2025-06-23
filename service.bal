import ballerina/http;
import khehan/tryone.database as db;

listener http:Listener userLsnr = new (8080);

@http:ServiceConfig {
    cors: {
        allowOrigins: ["http://localhost:5173"],
        allowMethods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"]
    }
}
service /users on userLsnr {

    # Create one or more users.
    # + users - Array of user objects supplied in the request payload
    # + return - `201 Created` on total success, `400 BadRequest` when at least one
    #            insert fails, or a generic `error` for unexpected failures
    isolated resource function post .(@http:Payload User[] users)
            returns http:Created|http:BadRequest|error {

        foreach User u in users {
            int|error id = db:insertUser(u);
            if id is error {
                return http:BAD_REQUEST;
            }
        }
        return http:CREATED;
    }

    # Fetch a single user by its primary-key ID.
    # + id - Path parameter identifying the user
    # + return - The `User` record with 200 OK on success, `404 NotFound`
    #            if no row matches, or an `error` for unexpected failures
    isolated resource function get [int id]()
            returns User|http:NotFound|error {

        User|error? row = db:getUser(id);
        if row is () {
            return http:NOT_FOUND;
        }
        return row;
    }

    
    # List all users or search by first / last name or email.
    # If `name` is supplied, a case-insensitive “LIKE %name%” search is
    # performed on first name, last name, and email.  
    # + name - Optional query parameter used as the search term
    # + return - Array of users with 200 OK on success, 500
    #            InternalServerError if the DB call fails, or error
    isolated resource function get .(string? name)
            returns User[]|http:InternalServerError|error {

        string like = name is () ? "" : "%" + name.toString() + "%";
        User[]|error list = db:searchUsers(like);
        if list is error {
            return http:INTERNAL_SERVER_ERROR;
        }
        return list;
    }

    # Update (replace) mutable columns of a user identified by ID.
    # + id - Path parameter identifying the user to update
    # + u - JSON payload containing the new field values
    # + return - 200 OK if exactly one row is updated, `400 BadRequest`
    #            if the update fails or affects zero rows, or `error`
    isolated resource function put [int id](@http:Payload User u)
            returns http:Ok|http:BadRequest|error {

        int|error rows = db:updateUser(id, u);
        if rows is error || rows == 0 {
            return http:BAD_REQUEST;
        }
        return http:OK;
    }

    # Delete the user identified by ID.
    # + id - Path parameter identifying the user to delete
    # + return - 204 NoContent if the row is deleted, `400 BadRequest`
    #            if no rows were affected, or `error`
    isolated resource function delete [int id]()
            returns http:NoContent|http:BadRequest|error {

        int|error rows = db:deleteUser(id);
        if rows is error || rows == 0 {
            return http:BAD_REQUEST;
        }
        return http:NO_CONTENT;
    }
}
