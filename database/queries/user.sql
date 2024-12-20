-- name: GetUsers :many
SELECT * FROM users;

-- name: InsertUser :one
INSERT INTO users (first_name, last_name, email, phone_number, password) VALUES ($1, $2, $3, $4, $5) RETURNING *;

-- name: GetUserById :one
SELECT * FROM users WHERE id = $1 AND deleted = FALSE;

-- name: GetUserByCredential :one
SELECT * FROM users WHERE email = $1 OR phone_number = $1 OR username = $1 AND deleted = FALSE;

-- name: UpdateUser :one
UPDATE users SET first_name = $1, last_name = $2, email = $3, phone_number = $4, password = $5, updated_at = CURRENT_TIMESTAMP WHERE id = $6 RETURNING *;

-- name: DeleteUser :one
UPDATE users SET deleted = TRUE WHERE id = $1 RETURNING *;