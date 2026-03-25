# RBT System API — Integration Documentation

**Base URL:** `https://staging.rbtsystem-api.com`
**Format:** All requests/responses are `application/json`
**Auth:** Bearer token via `Authorization: Bearer {token}` header

---

## Legend

| Icon | Meaning |
|---|---|
| 🔓 | Public — no token needed |
| 🔒 | Requires Bearer token |
| 🔑 | Requires `X-System-Key` header (system-to-system) |

---

## Table of Contents

1. [Authentication](#1-authentication)
2. [Users](#2-user-endpoints)
3. [Branches](#3-branch-endpoints)
4. [Systems](#4-system-endpoints)
5. [Audit Logs](#5-audit-logs)
6. [System-to-System](#6-system-to-system-routes)
7. [Quick Start](#7-quick-start--postman-setup)

---

## 1. Authentication

### 🔓 POST `/api/auth/login`

> Rate limited: 5 requests/min

Login with email or username. Optionally pass `system_slug` to receive role and permissions for a specific system.

**Request Body:**
```json
{
  "login": "admin@rbtbank.com",
  "password": "yourpassword",
  "system_slug": "mis"
}
```

| Field | Type | Required | Description |
|---|---|---|---|
| `login` | string | yes | Email or username |
| `password` | string | yes | User password |
| `system_slug` | string | no | System slug for access-scoped login |

**Response `200`:**
```json
{
  "success": true,
  "message": "Login successful.",
  "data": {
    "user": {
      "id": 1,
      "name": "Super Admin",
      "username": "admin",
      "email": "admin@rbtbank.com",
      "branch_id": 1,
      "branch": {
        "id": 1,
        "branch_name": "Head Office",
        "brak": "HO",
        "brcode": "001"
      },
      "employee_id": "EMP001",
      "department": "IT",
      "position": "MIS"
    },
    "token": "1|abc123...",
    "token_type": "Bearer",
    "access": {
      "role": "admin",
      "permissions": []
    }
  }
}
```

> `access` is only returned when `system_slug` is provided.

**Error Responses:**

| Code | Reason |
|---|---|
| `401` | Invalid credentials |
| `403` | Account deactivated or no access to requested system |

---

### 🔓 POST `/api/auth/register`

> Rate limited: 5 requests/min

**Request Body:**
```json
{
  "name": "Juan Dela Cruz",
  "username": "juan",
  "email": "juan@rbtbank.com",
  "password": "Password@123",
  "password_confirmation": "Password@123"
}
```

> **Password rules:** minimum 8 characters, mixed case, numbers, and symbols required.

**Response `201`:** Returns user object and Bearer token (same structure as login).

---

### 🔒 POST `/api/auth/logout`

Revokes the current token only.

**Response `200`:**
```json
{
  "success": true,
  "message": "Logged out successfully."
}
```

---

### 🔒 POST `/api/auth/logout-all`

Revokes all tokens across all devices.

**Response `200`:**
```json
{
  "success": true,
  "message": "Logged out from all devices successfully."
}
```

---

### 🔒 GET `/api/auth/profile`

Returns the full profile of the authenticated user.

**Response `200`:**
```json
{
  "success": true,
  "data": {
    "user": {
      "id": 1,
      "name": "Super Admin",
      "username": "admin",
      "email": "admin@rbtbank.com",
      "role": "admin",
      "is_active": true,
      "branch_id": 1,
      "branch": {
        "id": 1,
        "branch_name": "Head Office",
        "brak": "HO",
        "brcode": "001"
      },
      "employee_id": "EMP001",
      "department": "IT",
      "position": "MIS",
      "phone_number": null,
      "email_verified_at": null,
      "created_at": "2026-03-25T02:35:15.000000Z"
    }
  }
}
```

---

### 🔒 POST `/api/auth/refresh`

Revokes the current token and issues a new one.

**Response `200`:**
```json
{
  "success": true,
  "message": "Token refreshed successfully.",
  "data": {
    "token": "2|xyz...",
    "token_type": "Bearer"
  }
}
```

---

### 🔒 PUT `/api/auth/change-password`

**Request Body:**
```json
{
  "current_password": "OldPass@1",
  "password": "NewPass@1",
  "password_confirmation": "NewPass@1"
}
```

**Response `200`:** Returns a new token after the password is changed. All previous tokens are revoked.

**Error `422`:** Current password is incorrect.

---

### 🔒 GET `/api/auth/validate-token`

Used by other systems to verify a user's token and retrieve access info.

**Query Params (optional):**

| Param | Type | Description |
|---|---|---|
| `system_slug` | string | Returns access info for the specified system |

Or pass via header: `X-System-Slug: mis`

**Response `200`:**
```json
{
  "valid": true,
  "user": {
    "id": 1,
    "name": "Super Admin",
    "username": "admin",
    "email": "admin@rbtbank.com",
    "is_active": true,
    "branch_id": 1,
    "branch": {
      "id": 1,
      "branch_name": "Head Office",
      "brak": "HO",
      "brcode": "001"
    }
  },
  "access": {
    "role": "admin",
    "permissions": []
  }
}
```

> `access` is only returned when `system_slug` is provided.

---

## 2. User Endpoints

All endpoints require 🔒 Bearer token.

---

### GET `/api/users`

List all users with optional filtering.

**Query Params:**

| Param | Type | Description |
|---|---|---|
| `search` | string | Search by name, username, email, or employee_id |
| `role` | string | Filter by `admin` or `user` |
| `is_active` | boolean | Filter by `true` or `false` |
| `branch_id` | integer | Filter by branch ID |

**Response `200`:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "Super Admin",
      "username": "admin",
      "email": "admin@rbtbank.com",
      "role": "admin",
      "is_active": true,
      "branch_id": 1,
      "branch": {
        "id": 1,
        "branch_name": "Head Office",
        "brak": "HO",
        "brcode": "001"
      },
      "employee_id": "EMP001",
      "department": "IT",
      "position": "MIS",
      "phone_number": null,
      "systems": [
        {
          "id": 1,
          "name": "MIS System",
          "slug": "mis",
          "role": "admin",
          "is_active": true
        }
      ],
      "system_ids": [1],
      "system_access": {
        "1": { "enabled": true, "role": "admin" }
      },
      "created_at": "2026-03-25T02:35:15.000000Z",
      "updated_at": "2026-03-25T02:35:15.000000Z"
    }
  ]
}
```

---

### POST `/api/users`

Create a new user.

**Request Body:**
```json
{
  "name": "Juan Dela Cruz",
  "username": "juan",
  "email": "juan@rbtbank.com",
  "password": "Password@123",
  "password_confirmation": "Password@123",
  "role": "user",
  "is_active": true,
  "branch_id": 1,
  "employee_id": "EMP002",
  "department": "Operations",
  "position": "Teller",
  "phone_number": "09171234567",
  "system_ids": [1, 2]
}
```

| Field | Type | Required | Description |
|---|---|---|---|
| `name` | string | yes | Full name |
| `username` | string | yes | Unique, letters/numbers/dash/underscore only |
| `email` | string | yes | Unique email address |
| `password` | string | yes | Min 8 chars, mixed case, numbers, symbols |
| `password_confirmation` | string | yes | Must match password |
| `role` | string | no | `admin` or `user` (default: `user`) |
| `is_active` | boolean | no | Default: `true` |
| `branch_id` | integer | no | Must exist in branches table |
| `employee_id` | string | no | Unique employee ID |
| `department` | string | no | Department name |
| `position` | string | no | Job position |
| `phone_number` | string | no | Contact number |
| `system_ids` | array | no | Array of system IDs to assign access |

**Response `201`:** Returns full user object.

---

### GET `/api/users/{id}`

Get a single user by ID.

**Response `200`:** Returns full user object (same structure as list).

---

### PUT `/api/users/{id}`

Update a user. All fields are optional (partial updates supported). Accepts the same fields as `POST /api/users`.

**Response `200`:** Returns updated user object.

---

### DELETE `/api/users/{id}`

Delete a user and revoke all their tokens.

> Cannot delete your own account.

**Response `200`:**
```json
{
  "success": true,
  "message": "User deleted successfully."
}
```

---

### PATCH `/api/users/{id}/toggle-status`

Toggle `is_active` between `true` and `false`. Deactivating a user also revokes all their tokens.

> Cannot deactivate your own account.

**Response `200`:**
```json
{
  "success": true,
  "message": "User deactivated successfully.",
  "data": {
    "id": 2,
    "is_active": false
  }
}
```

---

### POST `/api/users/{id}/reset-password`

Admin resets another user's password. Revokes all their existing tokens.

**Request Body:**
```json
{
  "password": "NewPass@1",
  "password_confirmation": "NewPass@1"
}
```

**Response `200`:**
```json
{
  "success": true,
  "message": "Password reset successfully."
}
```

---

### PUT `/api/users/{id}/access`

Configure which systems a user can access, with per-system roles. Replaces all existing access (sync).

**Request Body:**
```json
{
  "systems": [
    { "id": 1, "role": "admin" },
    { "id": 2, "role": "cashier" }
  ]
}
```

> Passing `systems: []` removes all system access for the user.

**Response `200`:** Returns updated user object.

---

## 3. Branch Endpoints

---

### 🔓 GET `/api/branches/sync`

Public endpoint — no token required. Returns all branches for syncing to client system databases.

**Response `200`:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "branch_name": "Head Office",
      "brak": "HO",
      "brcode": "001",
      "parent_id": null,
      "is_active": true
    }
  ]
}
```

---

### 🔒 GET `/api/branches`

List all branches with optional filtering.

**Query Params:**

| Param | Type | Description |
|---|---|---|
| `search` | string | Search by branch_name, brak, or brcode |
| `is_active` | boolean | Filter active or inactive branches |

**Response `200`:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "branch_name": "Head Office",
      "brak": "HO",
      "brcode": "001",
      "parent_id": null,
      "is_active": true,
      "employees_count": 5,
      "created_at": "2026-03-25T02:35:15.000000Z",
      "updated_at": "2026-03-25T02:35:15.000000Z"
    }
  ]
}
```

---

### 🔒 GET `/api/branches/dropdown`

Returns active branches only, formatted for dropdown/select inputs.

**Response `200`:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "branch_name": "Head Office",
      "brak": "HO",
      "brcode": "001",
      "display_name": "001 - Head Office"
    }
  ]
}
```

---

### 🔒 GET `/api/branches/statistics`

Returns branch count summary.

**Response `200`:**
```json
{
  "success": true,
  "data": {
    "total_branches": 130,
    "active_branches": 128,
    "mother_branches": 50,
    "lite_branches": 80
  }
}
```

---

### 🔒 GET `/api/branches/{id}`

Get a single branch including its parent, children, and employee count.

**Response `200`:**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "branch_name": "Head Office",
    "brak": "HO",
    "brcode": "001",
    "parent_id": null,
    "is_active": true,
    "parent": null,
    "children": [
      { "id": 2, "branch_name": "Makati Branch", "brcode": "002" }
    ],
    "employees_count": 5,
    "created_at": "2026-03-25T02:35:15.000000Z",
    "updated_at": "2026-03-25T02:35:15.000000Z"
  }
}
```

---

### 🔒 POST `/api/branches`

Create a new branch.

**Request Body:**
```json
{
  "branch_name": "Makati Branch",
  "brak": "MKT",
  "brcode": "002",
  "parent_id": null
}
```

| Field | Type | Required | Description |
|---|---|---|---|
| `branch_name` | string | yes | Full branch name |
| `brak` | string | yes | Branch abbreviation |
| `brcode` | string | yes | Unique branch code |
| `parent_id` | integer | no | Parent branch ID (for sub/lite branches) |

**Response `201`:** Returns created branch object.

---

### 🔒 PUT `/api/branches/{id}`

Update a branch. All fields are optional.

**Request Body:**
```json
{
  "branch_name": "Makati Main Branch",
  "brak": "MKT",
  "brcode": "002",
  "parent_id": null,
  "is_active": true
}
```

**Response `200`:** Returns updated branch object.

---

### 🔒 DELETE `/api/branches/{id}`

Delete a branch.

> Fails with `422` if the branch has assigned employees or child branches.

**Response `200`:**
```json
{
  "success": true,
  "message": "Branch deleted successfully."
}
```

---

## 4. System Endpoints

All require 🔒 Bearer token.

---

### GET `/api/systems`

List all registered systems.

**Response `200`:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "MIS System",
      "slug": "mis",
      "description": "Management Information System",
      "base_url": "https://staging.mis.local",
      "is_active": true,
      "available_roles": ["admin", "user"],
      "created_at": "2026-03-25T02:35:15.000000Z"
    }
  ]
}
```

---

### POST `/api/systems`

Register a new system. An `api_key` is auto-generated — save it as it will not be shown again after this response.

**Request Body:**
```json
{
  "name": "Sigcard System",
  "slug": "sigcard",
  "description": "Signature Card Management",
  "base_url": "https://sigcard.staging.local"
}
```

| Field | Type | Required | Description |
|---|---|---|---|
| `name` | string | yes | Display name |
| `slug` | string | yes | Unique identifier, letters/numbers/dash/underscore |
| `description` | string | no | Short description |
| `base_url` | string | no | Must be a valid http/https URL |

**Response `201`:**
```json
{
  "success": true,
  "message": "System registered successfully.",
  "data": {
    "id": 2,
    "name": "Sigcard System",
    "slug": "sigcard",
    "description": "Signature Card Management",
    "base_url": "https://sigcard.staging.local",
    "is_active": true,
    "api_key": "abc123xyz...",
    "created_at": "2026-03-25T02:35:15.000000Z"
  }
}
```

---

### GET `/api/systems/{id}`

Get a single system including the count of assigned users.

**Response `200`:**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "name": "MIS System",
    "slug": "mis",
    "description": "Management Information System",
    "base_url": "https://staging.mis.local",
    "is_active": true,
    "users_count": 10,
    "created_at": "2026-03-25T02:35:15.000000Z"
  }
}
```

---

### PUT `/api/systems/{id}`

Update system details. All fields optional.

**Request Body:**
```json
{
  "name": "MIS System v2",
  "slug": "mis",
  "description": "Updated description",
  "base_url": "https://staging.mis.local",
  "is_active": true
}
```

**Response `200`:** Returns updated system object.

---

### POST `/api/systems/{id}/regenerate-key`

Generate a new API key for the system. The old key is immediately invalidated.

**Response `200`:**
```json
{
  "success": true,
  "message": "API key regenerated successfully.",
  "data": {
    "api_key": "newkey64chars..."
  }
}
```

---

## 5. Audit Logs

### 🔒 GET `/api/audit-logs`

Paginated list of all audit events across the system.

**Query Params:**

| Param | Type | Description |
|---|---|---|
| `user_id` | integer | Filter logs by user |
| `action` | string | Filter by action name (see actions below) |
| `from` | datetime | Start date e.g. `2026-01-01` |
| `to` | datetime | End date e.g. `2026-03-31` |
| `per_page` | integer | Items per page (default: `50`) |

**Logged Actions:**

| Action | Trigger |
|---|---|
| `register` | New user registered |
| `login` | Successful login |
| `failed_login` | Failed login attempt |
| `logout` | Single device logout |
| `logout_all` | All devices logout |
| `change_password` | User changed own password |
| `create_user` | Admin created a user |
| `update_user` | Admin updated a user |
| `delete_user` | Admin deleted a user |
| `user_activated` | User account activated |
| `user_deactivated` | User account deactivated |
| `admin_reset_password` | Admin reset a user's password |
| `configure_access` | System access configured for a user |

**Response `200`:**
```json
{
  "success": true,
  "data": {
    "current_page": 1,
    "data": [
      {
        "id": 1,
        "user_id": 1,
        "action": "login",
        "ip_address": "192.168.0.10",
        "user_agent": "Mozilla/5.0...",
        "metadata": { "system": "mis" },
        "created_at": "2026-03-25T06:00:00.000000Z",
        "user": {
          "id": 1,
          "name": "Super Admin",
          "email": "admin@rbtbank.com"
        }
      }
    ],
    "per_page": 50,
    "total": 200,
    "last_page": 4
  }
}
```

---

## 6. System-to-System Routes

For backend-to-backend communication. Requires `X-System-Key: {api_key}` header instead of user Bearer tokens.

---

### 🔑 POST `/api/system/validate-token`

Validates a user's Bearer token from within another system. Returns user info and access details.

**Headers:**
```
Authorization: Bearer {user_bearer_token}
X-System-Key: {your_system_api_key}
X-System-Slug: mis
```

**Response `200`:** Same as `GET /api/auth/validate-token`

---

### 🔑 GET `/api/system/check-access/{user_id}`

Check if a specific user has access to your system.

**Headers:**
```
X-System-Key: {your_system_api_key}
```

**Response `200`:**
```json
{
  "has_access": true,
  "user": {
    "id": 1,
    "name": "Super Admin",
    "email": "admin@rbtbank.com",
    "role": "admin",
    "is_active": true
  }
}
```

---

## 7. Quick Start — Postman Setup

### Step 1 — Add server to hosts file
On your PC, edit `C:\Windows\System32\drivers\etc\hosts` (Windows) or `/etc/hosts` (Mac/Linux):
```
192.168.0.2  staging.rbtsystem-api.com
```

### Step 2 — Disable SSL verification in Postman
Go to **Settings → General → SSL certificate verification → OFF**

### Step 3 — Login and get token
```
POST https://staging.rbtsystem-api.com/api/auth/login
Content-Type: application/json

{
  "login": "admin@rbtbank.com",
  "password": "your_password"
}
```

### Step 4 — Use the token
Add to all protected requests:
```
Authorization: Bearer {token}
```

### Step 5 — Set a Postman environment variable
| Variable | Value |
|---|---|
| `base_url` | `https://staging.rbtsystem-api.com` |
| `token` | *(paste from login response)* |

Then use `{{base_url}}/api/users` in your request URLs and `Bearer {{token}}` as the Authorization header.

---

## Common Error Responses

| Code | Meaning |
|---|---|
| `401` | Unauthenticated — missing or invalid token |
| `403` | Forbidden — account inactive or no system access |
| `404` | Resource not found |
| `422` | Validation error — check the `errors` field in response |
| `429` | Too many requests — rate limit exceeded |
| `500` | Server error |

**Validation error example `422`:**
```json
{
  "message": "The email field is required.",
  "errors": {
    "email": ["The email field is required."]
  }
}
```
