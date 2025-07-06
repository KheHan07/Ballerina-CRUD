# 🐘 User Management REST Service (Ballerina + MySQL)

A production-ready Ballerina service that exposes a REST/JSON API for managing users with a MySQL backend.  
It supports full **CRUD** and **bulk** operations, fuzzy search, and ships with OpenAPI docs out of the box.

## ✨ Features

| Capability                | Details                                                         |
|---------------------------|-----------------------------------------------------------------|
| **Create users (bulk)**   | Insert one **or many** users in a single POST                   |
| **Get user**              | Retrieve a single user by `id`                                  |
| **Search / List users**   | `GET /users` lists all, or filter by `name` / `email` (fuzzy)   |
| **Update user**           | `PUT /users/{id}` updates any mutable field                     |
| **Delete user**           | Hard-delete user by `id`                                        |
| **OpenAPI-first**         | Auto-generate OpenAPI 3 spec & Swagger UI                      |
| **Config-driven**         | DSN, port, pool size, etc. via `Config.toml`                    |
| **Docker-ready**          | One-command container build (optional)                          |

---

## 🛠️ Tech Stack

* **Language / Runtime:** [Ballerina Swan Lake 2201.12.6+](https://ballerina.io)  
* **Database:** MySQL 5.7+ (MariaDB 10.5+ works too)  
* **HTTP:** Ballerina `http` module (listens on `0.0.0.0:8080` by default)

## 🚀 Quick Start

### 1 Install prerequisites

| Tool        | Minimum version | Install link                              |
|-------------|-----------------|-------------------------------------------|
| Ballerina   | `2201.12.6`     | `brew install ballerina` / [other methods](https://ballerina.io/downloads/) |
| MySQL Server| `5.7`           | `apt install mysql-server` / Docker etc.  |

### 2 Clone & init DB

```bash
git clone https://github.com/<your-org>/ballerina-user-service.git
cd ballerina-user-service

# Create schema & table
mysql -u root -p < resources/database/userdb1.sql


[ballerinax.mysql.client]
host     = "localhost"
port     = 3306
user     = "root"
password = "root"
database = "userdb1"

poolOptions {
  maxOpenConnections = 10
  maxIdleConnections = 2
}

###Run the service 
bal run
# or build & run
bal build
bal run target/bin/user_service.jar

🖥️ Example cURL Commands
# 1 Create Users (bulk)
curl -X POST http://localhost:8080/users \
  -H "Content-Type: application/json" \
  -d '[
        { "id": 0, "firstName": "Ada",   "lastName": "Lovelace", "email": "ada@example.com",   "role": "engineer" },
        { "id": 0, "firstName": "Grace", "lastName": "Hopper",   "email": "grace@example.com", "role": "admiral" }
      ]'

# 2 List / Search
curl http://localhost:8080/users
curl http://localhost:8080/users?name=Ada
curl http://localhost:8080/users?email=example.com

# 3 Get by ID
curl http://localhost:8080/users/1

# 4 Update
curl -X PUT http://localhost:8080/users/1 \
  -H "Content-Type: application/json" \
  -d '{ "id": 1, "firstName": "Ada", "lastName": "Lovelace",
        "email": "ada@example.com", "role": "chief engineer" }'

# 5 Delete
curl -X DELETE http://localhost:8080/users/1
