import ballerinax/java.jdbc;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

// DatabaseConfig record that loads connection info from the Config.toml
configurable DatabaseConfig databaseConfig = ?;

// Build a single client config object
// SSL only protects network traffic.
DatabaseClientConfig dbClientConfig = {
    ...databaseConfig,
    options: {
        ssl: { mode: mysql:SSL_REQUIRED },  // enforce encryption
        connectTimeout: 10                  // 10-second connect timeout
    }
};

// Helper to instantiate the MySQL client
function initDbClient() returns mysql:Client|error {
    return new (...dbClientConfig);
}

// Expose the client as a generic JDBC interface
public final jdbc:Client dbClient = check initDbClient();
