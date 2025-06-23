import ballerina/sql;
import ballerinax/mysql;

# Configuration values required to open a MySQL connection.
#
# + user - Database user name
# + password - Password that belongs to it
# + host - Host-name or IP address of the MySQL server
# + port - TCP port on which the server listens
# + database - Schema
# + connectionPool - Optional pool config, the connector uses its internal defaults
public type DatabaseConfig record {|
    string user;
    string password;
    string host;
    int    port;
    string database;
    sql:ConnectionPool? connectionPool = ();
|};

# Application-level representation of a row in the `users` table.
#
# + id - user id
# + firstName - Person’s given name
# + lastName - Person’s family / surname
# + email - Unique e-mail address 
# + role - unctional title or access role
# + createdOn - Timestamp recorded by MySQL when the row was first inserted
# + updatedOn - Timestamp updated automatically on every modification
public type User record {|
    int?    id?;           //optional primary-key
    string  firstName;
    string  lastName;
    string  email;
    string  role;
    string? createdOn?;    //optional timestamp
    string? updatedOn?;    //optional timestamp
|};

# Extended configuration that includes database connection options.
// this extends it by adding extra settings like SSL and connection timeout
type DatabaseClientConfig record {|
    *DatabaseConfig;
    # Additional configurations related to the MySQL database connection
    mysql:Options? options;
|};