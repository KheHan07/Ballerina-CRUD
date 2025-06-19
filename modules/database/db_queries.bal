import ballerina/sql;

// ---------- INSERT ---------------------------------------------------------
public isolated function qInsert(User u) returns sql:ParameterizedQuery => `
    INSERT INTO users (first_name, last_name, email, role)
           VALUES (${u.firstName}, ${u.lastName}, ${u.email}, ${u.role})
`;

// ---------- SELECT by id ----------------------------------------------------
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

// ---------- LIST / SEARCH ---------------------------------------------------
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

// ---------- UPDATE ----------------------------------------------------------
public isolated function qUpdate(int id, User u) returns sql:ParameterizedQuery
        => `
    UPDATE users
       SET first_name = ${u.firstName},
           last_name  = ${u.lastName},
           email      = ${u.email},
           role       = ${u.role}
     WHERE user_id    = ${id}
`;

// ---------- DELETE ----------------------------------------------------------
public isolated function qDelete(int id) returns sql:ParameterizedQuery => `
    DELETE FROM users WHERE user_id = ${id}
`;
