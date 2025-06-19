import ballerina/sql;

//INSERT
# Builds an INSERT statement for a new row in the users table.
#
# + u - The payload contain first name,last name,email, and role values
# + return - fully parameterized INSERT VALUES () query
public isolated function qInsert(User u) returns sql:ParameterizedQuery => `
    INSERT INTO users (first_name, last_name, email, role)
           VALUES (${u.firstName}, ${u.lastName}, ${u.email}, ${u.role})
`;

//SELECT by id
# Builds a SELECT statement to get one user by id.
#
# + id - user_id
# + return - SELECT … WHERE user_id = ${id} query
public isolated function qById(int id) returns sql:ParameterizedQuery => `
    SELECT user_id   AS id,
           first_name AS firstName,
           last_name  AS lastName,
           email,
           role,
           created_on AS createdOn,
           updated_on AS updatedOn
      FROM users
     WHERE user_id = ${id}
`;

//SEARCH to getall
# Returns all users.
# + return - A `SELECT … FROM users` query
public isolated function qAll() returns sql:ParameterizedQuery => `
    SELECT user_id   AS id,
           first_name AS firstName,
           last_name  AS lastName,
           email,
           role,
           created_on AS createdOn,
           updated_on AS updatedOn
      FROM users
`;

# search SELECT that matches first/last name or email.
#
# + like - A pattern
# + return - A `SELECT … WHERE … LIKE` query
public isolated function qSearch(string like) returns sql:ParameterizedQuery => `
    SELECT user_id   AS id,
           first_name AS firstName,
           last_name  AS lastName,
           email,
           role,
           created_on AS createdOn,
           updated_on AS updatedOn
      FROM users
     WHERE first_name LIKE ${like}
        OR last_name  LIKE ${like}
        OR email      LIKE ${like}
`;

//UPDATE
# UPDATE statement for the row identified by id.
#
# + id - id of the row to modify 
# + u - new values to write into `first_name`, `last_name`, `email`, and `role`
# + return - A `UPDATE … SET … WHERE user_id = ${id}` query
public isolated function qUpdate(int id, User u) returns sql:ParameterizedQuery
        => `
    UPDATE users
       SET first_name = ${u.firstName},
           last_name  = ${u.lastName},
           email      = ${u.email},
           role       = ${u.role}
     WHERE user_id    = ${id}
`;

//DELETE
# delete statement that removes one row by id.
#
# + id - `user_id` value
# + return - `DELETE FROM users WHERE user_id = ${id}` query
public isolated function qDelete(int id) returns sql:ParameterizedQuery => `
    DELETE FROM users WHERE user_id = ${id}
`;
