# Data Dictionary - PT. Smart CRM

This document provides a detailed breakdown of the database schema for the System Analyst review.

## 👥 Users Table
Controls access and authentication.
- `id`: Primary key.
- `username`: Unique username for login.
- `email`: Unique email for login.
- `password_digest`: Hashed password (BCrypt).
- `role`: Controls permissions (`admin`, `manager`, `sales`, `staff`, `user`).
- `banned`: Boolean flag for account access suspension.

## 📈 Leads Table
Stores prospective customers (prospek).
- `id`: Primary key.
- `name`: Prospect or Company name.
- `status`: Lifecycle of lead (`New`, `Contacted`, `Qualified`, `Closed`).
- `lat`, `long`: Geolocation for site survey and service availability checks.

## 📦 Products Table
Service catalog of internet packages.
- `id`: Primary key.
- `name`: Package marketing name.
- `price`: Monthly recurring cost in IDR.

## 📁 Projects Table
Transactional link between Leads and Products.
- `id`: Primary key.
- `lead_id`: Foreign key to `leads`.
- `product_id`: Foreign key to `products`.
- `user_id`: Foreign key to `users` (Sales person responsible).
- `status`: `Pending Approval` (waiting for manager) or `Approved` (becomes active customer).
- `svc_code`: Unique identifier (e.g., `SMART-xxxx`) generated upon manager approval.
- `approved_at`: Timestamp of manager sign-off.

## 🎯 Sales Targets Table
- `id`: Primary key.
- `amount`: Target revenue in IDR.
- `month`, `year`: Target period.

---
## 🔄 Relationships (ERD Summary)
1. **User 1 : N Project**: Each project is assigned to a specific sales staff.
2. **Lead 1 : N Project**: A lead can have multiple project requests (different services).
3. **Product 1 : N Project**: A product can be associated with many projects.
