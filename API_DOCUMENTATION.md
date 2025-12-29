# IMIS API Documentation

Base URL: `http://localhost:8000` (development)

## Authentication Endpoints

### POST /auth/register
Register a new user.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securepassword",
  "full_name": "John Doe",
  "phone": "+250788123456"
}
```

**Response:**
```json
{
  "id": 1,
  "email": "user@example.com",
  "full_name": "John Doe",
  "role": "user"
}
```

### POST /auth/login
Login and receive JWT token.

**Request Body:**
```json
{
  "email": "user@example.com",
  "password": "securepassword"
}
```

**Response:**
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer"
}
```

## Item Endpoints

### POST /items/
Create a new lost or found item (requires authentication).

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "title": "Black iPhone 13",
  "description": "Lost near City Market",
  "category": "phone",
  "status": "lost",
  "location_name": "Kigali City Market",
  "latitude": -1.9536,
  "longitude": 30.0606,
  "date_lost_found": "2025-01-15T10:30:00Z"
}
```

### GET /items/
Get all active items.

**Query Parameters:**
- `skip`: Offset (default: 0)
- `limit`: Limit (default: 50)

### GET /items/{item_id}
Get specific item details.

### GET /items/{item_id}/matches
Get AI-matched items (requires authentication).

### DELETE /items/{item_id}
Soft delete an item (requires authentication, owner only).

## Message Endpoints

### POST /messages/
Send a message (requires authentication).

**Request Body:**
```json
{
  "receiver_id": 2,
  "item_id": 1,
  "content": "I think I found your item"
}
```

### GET /messages/
Get all messages for current user (requires authentication).

### PUT /messages/{message_id}/read
Mark message as read (requires authentication).

## Admin Endpoints

### GET /admin/stats
Get system statistics (requires admin role).

**Response:**
```json
{
  "total_users": 150,
  "total_items": 320,
  "lost_items": 180,
  "found_items": 140,
  "recovered_items": 45,
  "total_commissions": 1250.50
}
```

### GET /admin/commissions
Get all commissions (requires admin role).

### POST /admin/commissions/{item_id}
Create commission for recovered item (requires admin role).

**Request Body:**
```json
{
  "amount": 50.00
}
```

### GET /admin/users
Get all users (requires admin role).

## Error Responses

**401 Unauthorized:**
```json
{
  "detail": "Invalid token"
}
```

**403 Forbidden:**
```json
{
  "detail": "Admin access required"
}
```

**404 Not Found:**
```json
{
  "detail": "Item not found"
}
```

## Interactive Documentation

Visit `/docs` for Swagger UI interactive documentation.
Visit `/redoc` for ReDoc documentation.
