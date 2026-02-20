# Finance Tracker API Guide

Complete API documentation with request/response examples for all endpoints.

---

## Base URL
```
http://localhost:8080
```

---

## Response Format

All responses follow a consistent structure:

### Success Response
```json
{
  "success": true,
  "data": { ... },
  "message": "Descriptive message",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

### Error Response
```json
{
  "success": false,
  "error": "Error message",
  "details": [
    {
      "field": "fieldName",
      "message": "Specific error message"
    }
  ],
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

---

## Endpoints

### 1. Get All Transactions

**GET** `/transactions`

Retrieves all transactions sorted by date (newest first).

#### Request
No request body required.

#### Response (200 OK)
```json
{
  "success": true,
  "data": [
    {
      "id": "507f1f77bcf86cd799439011",
      "title": "Monthly Salary",
      "amount": 15000000,
      "type": "income",
      "category": "Salary",
      "date": "2024-06-15T10:30:00.000Z",
      "note": "June 2024 salary"
    },
    {
      "id": "507f191e810c19729de860ea",
      "title": "Grocery Shopping",
      "amount": 450000,
      "type": "expense",
      "category": "Food",
      "date": "2024-06-14T08:00:00.000Z"
    }
  ],
  "meta": {
    "total": 2,
    "count": 2,
    "timestamp": "2024-06-20T14:30:00.000Z"
  },
  "message": "Transactions retrieved successfully"
}
```

---

### 2. Get Transaction by ID

**GET** `/transactions/:id`

Retrieves a single transaction by its ID.

#### Request
**URL Parameter:**
- `id` (string, required) - MongoDB ObjectId

**Example:**
```
GET /transactions/507f1f77bcf86cd799439011
```

#### Response (200 OK)
```json
{
  "success": true,
  "data": {
    "id": "507f1f77bcf86cd799439011",
    "title": "Monthly Salary",
    "amount": 15000000,
    "type": "income",
    "category": "Salary",
    "date": "2024-06-15T10:30:00.000Z",
    "note": "June 2024 salary"
  },
  "message": "Transaction retrieved successfully",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

#### Error Response (400 Bad Request)
```json
{
  "success": false,
  "error": "Invalid id format",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

#### Error Response (404 Not Found)
```json
{
  "success": false,
  "error": "Transaction not found",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

---

### 3. Create Transaction

**POST** `/transactions`

Creates a new transaction.

#### Request Body
```json
{
  "title": "Freelance Project",
  "amount": 5000000,
  "type": "income",
  "category": "Freelance",
  "date": "2024-06-20T10:00:00Z",
  "note": "Website development project"
}
```

**Field Specifications:**

| Field | Type | Required | Validation |
|-------|------|----------|------------|
| `title` | string | ✅ Yes | Non-empty string |
| `amount` | number | ✅ Yes | Positive number (> 0) |
| `type` | string | ✅ Yes | Must be "income" or "expense" |
| `category` | string | ✅ Yes | Non-empty string |
| `date` | string | ✅ Yes | ISO 8601 date format |
| `note` | string | ❌ No | Optional string |

#### Response (201 Created)
```json
{
  "success": true,
  "data": {
    "id": "507f1f77bcf86cd799439011",
    "title": "Freelance Project",
    "amount": 5000000,
    "type": "income",
    "category": "Freelance",
    "date": "2024-06-20T10:00:00.000Z",
    "note": "Website development project"
  },
  "message": "Transaction created successfully",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

#### Error Response (400 Bad Request)
```json
{
  "success": false,
  "error": "Validation failed",
  "details": [
    {
      "field": "amount",
      "message": "amount must be a positive number"
    },
    {
      "field": "type",
      "message": "type must be 'income' or 'expense'"
    }
  ],
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

---

### 4. Update Transaction

**PATCH** `/transactions/:id`

Updates an existing transaction. Only provided fields will be updated.

#### Request
**URL Parameter:**
- `id` (string, required) - MongoDB ObjectId

**Request Body (all fields optional):**
```json
{
  "title": "Updated Freelance Project",
  "amount": 5500000,
  "note": "Updated payment amount"
}
```

**Field Specifications:**

| Field | Type | Required | Validation |
|-------|------|----------|------------|
| `title` | string | ❌ No | Non-empty string if provided |
| `amount` | number | ❌ No | Positive number if provided |
| `type` | string | ❌ No | "income" or "expense" if provided |
| `category` | string | ❌ No | Non-empty string if provided |
| `date` | string | ❌ No | ISO 8601 format if provided |
| `note` | string | ❌ No | String if provided |

#### Response (200 OK)
```json
{
  "success": true,
  "data": {
    "id": "507f1f77bcf86cd799439011",
    "title": "Updated Freelance Project",
    "amount": 5500000,
    "type": "income",
    "category": "Freelance",
    "date": "2024-06-20T10:00:00.000Z",
    "note": "Updated payment amount"
  },
  "message": "Transaction updated successfully",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

#### Error Response (400 Bad Request - No Fields)
```json
{
  "success": false,
  "error": "No fields to update",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

#### Error Response (400 Bad Request - Invalid ID)
```json
{
  "success": false,
  "error": "Invalid id format",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

#### Error Response (404 Not Found)
```json
{
  "success": false,
  "error": "Transaction not found",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

---

### 5. Delete Transaction

**DELETE** `/transactions/:id`

Deletes a transaction by ID.

#### Request
**URL Parameter:**
- `id` (string, required) - MongoDB ObjectId

**Example:**
```
DELETE /transactions/507f1f77bcf86cd799439011
```

#### Response (200 OK)
```json
{
  "success": true,
  "data": null,
  "message": "Transaction deleted successfully",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

#### Error Response (400 Bad Request)
```json
{
  "success": false,
  "error": "Invalid id format",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

#### Error Response (404 Not Found)
```json
{
  "success": false,
  "error": "Transaction not found",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

---

### 6. Get Financial Summary

**GET** `/summary`

Retrieves financial summary with totals and transaction counts.

#### Request
No request body required.

#### Response (200 OK)
```json
{
  "success": true,
  "data": {
    "total_income": 20000000,
    "total_expenses": 5500000,
    "net_balance": 14500000,
    "transaction_count": {
      "income": 5,
      "expense": 12,
      "total": 17
    }
  },
  "meta": {
    "timestamp": "2024-06-20T14:30:00.000Z",
    "currency": "IDR"
  },
  "message": "Financial summary retrieved successfully"
}
```

---

## Complete Request/Response Examples

### Example 1: Create Income Transaction

**Request:**
```bash
curl -X POST http://localhost:8080/transactions \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Salary June 2024",
    "amount": 15000000,
    "type": "income",
    "category": "Salary",
    "date": "2024-06-01T00:00:00Z",
    "note": "Monthly salary payment"
  }'
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "507f1f77bcf86cd799439011",
    "title": "Salary June 2024",
    "amount": 15000000,
    "type": "income",
    "category": "Salary",
    "date": "2024-06-01T00:00:00.000Z",
    "note": "Monthly salary payment"
  },
  "message": "Transaction created successfully",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

---

### Example 2: Create Expense Transaction

**Request:**
```bash
curl -X POST http://localhost:8080/transactions \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Grocery Shopping",
    "amount": 750000,
    "type": "expense",
    "category": "Food",
    "date": "2024-06-15T08:30:00Z"
  }'
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "507f191e810c19729de860ea",
    "title": "Grocery Shopping",
    "amount": 750000,
    "type": "expense",
    "category": "Food",
    "date": "2024-06-15T08:30:00.000Z"
  },
  "message": "Transaction created successfully",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

---

### Example 3: Update Transaction

**Request:**
```bash
curl -X PATCH http://localhost:8080/transactions/507f1f77bcf86cd799439011 \
  -H "Content-Type: application/json" \
  -d '{
    "amount": 16000000,
    "note": "Salary with bonus"
  }'
```

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "507f1f77bcf86cd799439011",
    "title": "Salary June 2024",
    "amount": 16000000,
    "type": "income",
    "category": "Salary",
    "date": "2024-06-01T00:00:00.000Z",
    "note": "Salary with bonus"
  },
  "message": "Transaction updated successfully",
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

---

### Example 4: Validation Error

**Request:**
```bash
curl -X POST http://localhost:8080/transactions \
  -H "Content-Type: application/json" \
  -d '{
    "title": "",
    "amount": -100,
    "type": "invalid",
    "category": "Food"
  }'
```

**Response:**
```json
{
  "success": false,
  "error": "Validation failed",
  "details": [
    {
      "field": "title",
      "message": "title is required and must be a non-empty string"
    },
    {
      "field": "amount",
      "message": "amount must be a positive number"
    },
    {
      "field": "type",
      "message": "type must be 'income' or 'expense'"
    },
    {
      "field": "date",
      "message": "date is required"
    }
  ],
  "timestamp": "2024-06-20T14:30:00.000Z"
}
```

---

## Common Error Codes

| Status Code | Description | Example |
|-------------|-------------|---------|
| 200 | Success | GET, PATCH requests |
| 201 | Created | POST requests |
| 400 | Bad Request | Validation errors, invalid ID format |
| 404 | Not Found | Transaction or route not found |
| 409 | Conflict | Duplicate entry |
| 500 | Internal Server Error | Unexpected server errors |

---

## Transaction Categories (Suggestions)

### Income Categories
- Salary
- Freelance
- Investment
- Business
- Gift
- Other Income

### Expense Categories
- Food
- Transport
- Shopping
- Bills
- Entertainment
- Healthcare
- Education
- Other Expense

---

## Date Format

All dates must be in **ISO 8601** format:

**Valid formats:**
- `2024-06-20T14:30:00Z`
- `2024-06-20T14:30:00.000Z`
- `2024-06-20T14:30:00+07:00`

**Invalid formats:**
- `2024-06-20` (missing time)
- `20/06/2024` (wrong format)
- `June 20, 2024` (not ISO 8601)

---

## Testing with cURL

### Get all transactions
```bash
curl http://localhost:8080/transactions
```

### Get single transaction
```bash
curl http://localhost:8080/transactions/507f1f77bcf86cd799439011
```

### Create transaction
```bash
curl -X POST http://localhost:8080/transactions \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Test Transaction",
    "amount": 100000,
    "type": "expense",
    "category": "Test",
    "date": "2024-06-20T10:00:00Z"
  }'
```

### Update transaction
```bash
curl -X PATCH http://localhost:8080/transactions/507f1f77bcf86cd799439011 \
  -H "Content-Type: application/json" \
  -d '{"amount": 150000}'
```

### Delete transaction
```bash
curl -X DELETE http://localhost:8080/transactions/507f1f77bcf86cd799439011
```

### Get summary
```bash
curl http://localhost:8080/summary
```

---

## Postman Collection

Import this JSON into Postman for quick testing:

```json
{
  "info": {
    "name": "Finance Tracker API",
    "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
  },
  "item": [
    {
      "name": "Get All Transactions",
      "request": {
        "method": "GET",
        "url": "{{baseUrl}}/transactions"
      }
    },
    {
      "name": "Create Transaction",
      "request": {
        "method": "POST",
        "header": [{"key": "Content-Type", "value": "application/json"}],
        "url": "{{baseUrl}}/transactions",
        "body": {
          "mode": "raw",
          "raw": "{\n  \"title\": \"Test Transaction\",\n  \"amount\": 100000,\n  \"type\": \"expense\",\n  \"category\": \"Food\",\n  \"date\": \"2024-06-20T10:00:00Z\"\n}"
        }
      }
    }
  ],
  "variable": [
    {
      "key": "baseUrl",
      "value": "http://localhost:8080"
    }
  ]
}
```

---

## Notes

- All monetary amounts are in **Indonesian Rupiah (IDR)**
- Transaction IDs are **MongoDB ObjectIds** (24-character hex strings)
- All timestamps are in **UTC** timezone
- The API uses **JSON** for all request/response bodies
- **CORS** is enabled for all origins
