import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// Defined a configurable record that will hold connection details
configurable DatabaseConfig databaseConfig = ?;
// Set MySQL connection options disabling- SSL in this case
mysql:Options opts = {ssl: {mode: mysql:SSL_DISABLED}};

// Create and initialise a single MySQL client instance
public final mysql:Client dbClient = check new (
    host     = databaseConfig.host,
    port     = databaseConfig.port,
    user     = databaseConfig.user,
    password = databaseConfig.password,
    database = databaseConfig.database,
    options  = opts
);