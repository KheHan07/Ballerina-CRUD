import ballerina/sql;

# Insert a new user row .
# 
# + u - Payload containing firstName, lastName, email, role
# + return - user_id or sql:Error
public isolated function insertUser(User u) returns int|error {
    sql:ExecutionResult res = check dbClient->execute(qInsert(u));
    return <int>res.lastInsertId;
}

# Retrieve a single user by primary key.
#
# + id - `id` column value
# + return - `User` record or sqlError
public isolated function getUser(int id) returns User|error? {
    User|sql:Error row = dbClient->queryRow(qById(id), User);
    if row is sql:NoRowsError {
        return ();
    }
    return row;
}

# fuzzy search on first/last name or email.
#
# + like - Pattern or empty string means all rows
# + return - Array of User or sql:Error
public isolated function searchUsers(string like) returns User[]|error {
    sql:ParameterizedQuery q = like == "" ? qAll() : qSearch(like);
    stream<User,error?> rs  = dbClient->query(q, User);

    User[] list = [];
    check from User u in rs do { list.push(u); };
    return list;
}

# Update the row identified by id.
#
# + id - Primary key
# + u - New column values
# + return - Number of affected rows or error
public isolated function updateUser(int id, User u) returns int|error {
    sql:ExecutionResult res = check dbClient->execute(qUpdate(id, u));
    return <int>res.affectedRowCount;
}

# Description.
#
# + id - Delete the row identified by id
# + return - Number of rows removed or error
public isolated function deleteUser(int id) returns int|error {
    sql:ExecutionResult res = check dbClient->execute(qDelete(id));
    return <int>res.affectedRowCount;
}
