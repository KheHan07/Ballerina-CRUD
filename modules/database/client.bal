import ballerinax/mysql;
import ballerinax/mysql.driver as _;

configurable DatabaseConfig databaseConfig = ?;

mysql:Options opts = {ssl: {mode: mysql:SSL_DISABLED}};

public final mysql:Client dbClient = check new (
    host     = databaseConfig.host,
    port     = databaseConfig.port,
    user     = databaseConfig.user,
    password = databaseConfig.password,
    database = databaseConfig.database,
    options  = opts
);
