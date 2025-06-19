import ballerina/sql;

public isolated function insertUser(User u) returns int|error {
    sql:ExecutionResult res = check dbClient->execute(qInsert(u));
    return <int>res.lastInsertId;
}

public isolated function getUser(int id) returns User|error? {
    User|sql:Error row = dbClient->queryRow(qById(id), User);
    if row is sql:NoRowsError {
        return ();
    }
    return row;
}

public isolated function searchUsers(string like) returns User[]|error {
    sql:ParameterizedQuery q = like == "" ? qAll() : qSearch(like);
    stream<User,error?> rs  = dbClient->query(q, User);

    User[] list = [];
    check from User u in rs do { list.push(u); };
    return list;
}

public isolated function updateUser(int id, User u) returns int|error {
    sql:ExecutionResult res = check dbClient->execute(qUpdate(id, u));
    return <int>res.affectedRowCount;
}

public isolated function deleteUser(int id) returns int|error {
    sql:ExecutionResult res = check dbClient->execute(qDelete(id));
    return <int>res.affectedRowCount;
}
