# Nicholas CRM - PT. Smart (ISP)

> "The path ahead may be uncertain, but with a steady step and an open mind, can navigate the unknown and discover new possibilities"

A modern, web-based Customer Relationship Management (CRM) application for PT. Smart (Internet Service Provider), designed to digitize sales operations and eliminate paper-based re-capitulation.

---

## 🛠️ Methodology & Tools
- **Framework**: Ruby on Rails 8.1 (Latest)
- **Database**: PostgreSQL v14 compliant (Primary), SQLite (used for local submission demo)
- **Design**: Tailwind CSS for modern aesthetics.
- **Tools**: 
  - **DBeaver**: Used for schema visualization and relational integrity checks.
  - **Draw.io**: Used for planning the internal project approval flow.
  - **Localtunnel**: Used for public cloud accessibility without credit card barriers.

---

## 📚 Data Dictionary (Schema Description)

### 1. `users`
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | BigInt | Primary Key |
| `name` | String | Full Name of user |
| `username` | String | Unique username for login |
| `email` | String | Unique email for login |
| `password_digest` | String | Encrypted password (BCrypt) |
| `role` | String | `admin`, `manager`, `sales`, `user` |
| `banned` | Boolean | Account status |

### 2. `leads`
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | BigInt | Primary Key |
| `name` | String | Prospect Name |
| `status` | String | `New`, `Contacted`, `Qualified`, `Closed` |
| `lat`, `long` | Decimal | Geo-coordinates for site survey |
| `deleted_at` | DateTime | Soft-delete timestamp |

### 3. `products`
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | BigInt | Primary Key |
| `name` | String | Internet package name (e.g., Smart Home 50Mbps) |
| `price` | Decimal | Monthly subscription fee |

### 4. `projects`
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | BigInt | Primary Key |
| `lead_id` | FK | Associated Lead |
| `product_id` | FK | Associated Product |
| `user_id` | FK | Assigned Sales Staff |
| `status` | String | `Pending Approval`, `Approved` |
| `svc_code` | String | Unique Service Identifier generated post-approval |

---

## � Installation & Local Setup

### 1. Prerequisites
- Ruby 3.2+
- Node.js & Yarn
- PostgreSQL 14 (Optional, can run on SQLite for quick review)

### 2. Setup
```bash
# Clone
git clone https://github.com/Choliem/nicholas_crm.git
cd nicholas_crm

# Install
bundle install

# Prepare DB
rails db:migrate
rails db:seed

# Run
rails s
```
Access at: `http://localhost:3000`

---

## ☁️ Deployment (Online Access)
Due to cloud platform credit card requirements, this app is deployed via **Localtunnel**.
1.  Verify the server is running (`rails s`).
2.  Tunnel URL: Use the `.loca.lt` link provided in the submission.
3.  **Tunnel Password**: If asked, visit [https://loca.lt/mytunnelpassword](https://loca.lt/mytunnelpassword) on the server machine to get your Public IP.

---

## 🔑 Default Credentials
| Role | Email | Password |
| :--- | :--- | :--- |
| **Admin** | `admin@smart.com` | `password123` |
| **Manager** | `manager@smart.com` | `password123` |
| **Sales** | `sales@smart.com` | `password123` |

---

## 📝 Design Decisions
1.  **RBAC Logic**: `Manager` approval is strictly required before a `Lead` becomes an active `Project` with a `Service Code`.
2.  **Soft Deletion**: Implemented to allow recovery of accidentally deleted leads, common in CRM operations.
3.  **Modern Hero UI**: The landing page uses a high-contrast dark theme for the required quote and a professional ISP hero section.
