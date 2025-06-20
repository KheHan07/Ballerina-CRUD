import ballerina/http;
import khehan/tryone.database as db;

listener http:Listener userLsnr = new (8080);

service /users on userLsnr {

    //  CREATE (bulk) 
    //Insert one or more users in a single request
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

    //  READ single 
    //Fetch a user by primary key
    isolated resource function get [int id]()
            returns User|http:NotFound|error {

        User|error? row = db:getUser(id);
        if row is () {
            return http:NOT_FOUND;
        }
        return row;
    }

    // SEARCH / list 
    //List all users or do a search on first / last name or email
    isolated resource function get .(string? name)
            returns User[]|http:InternalServerError|error {

        string like = name is () ? "" : "%" + name.toString() + "%";
        User[]|error list = db:searchUsers(like);
        if list is error {
            return http:INTERNAL_SERVER_ERROR;
        }
        return list;
    }

    // UPDATE
    //Replace mutable columns of the user identified by id
    isolated resource function put [int id](@http:Payload User u)
            returns http:Ok|http:BadRequest|error {

        int|error rows = db:updateUser(id, u);
        if rows is error || rows == 0 {
            return http:BAD_REQUEST;
        }
        return http:OK;
    }

    // DELETE
    //Remove the user identified by id
    isolated resource function delete [int id]()
            returns http:NoContent|http:BadRequest|error {

        int|error rows = db:deleteUser(id);
        if rows is error || rows == 0 {
            return http:BAD_REQUEST;
        }
        return http:NO_CONTENT;
    }
}
