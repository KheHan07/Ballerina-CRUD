import ballerina/sql;

public type DatabaseConfig record {|
    string user;
    string password;
    string host;
    int    port;
    string database;
    sql:ConnectionPool? connectionPool = ();
|};

public type User record {|
    int?   id;          // optional when inserting
    string firstName;
    string lastName;
    string email;
    string role;
    string? createdOn;
    string? updatedOn;
|};
