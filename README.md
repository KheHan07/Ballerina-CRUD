# 🐘 User Management REST Service (Ballerina + MySQL)

A production-ready Ballerina service that exposes a REST/JSON API for managing users with a MySQL backend.  
It supports full **CRUD** and **bulk** operations, fuzzy search, and ships with OpenAPI docs out of the box.

> **Why Ballerina?**  
> Declarative networking, built-in database client, cloud-native friendliness, and first-class OpenAPI tooling—all in one modern language.

---

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

---

## 🗂️ Project Structure

