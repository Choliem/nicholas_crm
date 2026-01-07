# Nicholas CRM - PT. Smart

A web-based Customer Relationship Management (CRM) application for PT. Smart (ISP), designed to digitize sales operations, manage leads, products, and customer subscriptions.

**Author**: Nicholas Liemotto  
**Tech Stack**: Ruby on Rails 7, PostgreSQL, Tailwind CSS

---

## 🚀 Features

*   **Role-Based Access Control (RBAC)**:
    *   **Member**: Can only view the Public Product Catalog.
    *   **Staff**: Can manage Leads and Projects.
    *   **Manager**: Can approve projects, manage products, and set sales targets.
    *   **Admin**: Full access including User Management (Ban/Unban/Role Change).
*   **Lead Management**: Track potential customers with location data (Lat/Long) and status.
*   **Project Workflow**: Process leads into projects with Manager approval system.
*   **Product Catalog**: Modern pricing table for internet packages.
*   **Dashboard**: Real-time sales monitoring with monthly targets and charts.
*   **Soft Delete**: Data safety with `deleted_at` implementation.
*   **Responsive UI**: Optimized for Mobile and Desktop with Tailwind CSS.

---

## 🛠️ Installation & Setup (Local)

### Prerequisites
*   Ruby 3.x
*   PostgreSQL 14+
*   Node.js & Yarn (for CSS bundling if needed)

### Steps
1.  **Clone the Repository**
    ```bash
    git clone https://github.com/your-username/nicholas_crm.git
    cd nicholas_crm
    ```

2.  **Install Dependencies**
    ```bash
    bundle install
    ```

3.  **Setup Database**
    ```bash
    # Update config/database.yml with your postgres credentials if needed
    rails db:create
    rails db:migrate
    rails db:seed
    ```
    *Note: `rails db:seed` will create a default Admin, Manager, Sales, Staff, and User for testing.*

4.  **Run the Server**
    ```bash
    rails server
    ```
    Access the app at `http://localhost:3000`

---

## ☁️ Deployment (Heroku)

This application is ready for Heroku deployment.

1.  **Login to Heroku CLI**
    ```bash
    heroku login
    ```

2.  **Create App**
    ```bash
    heroku create nicholas-crm-demo
    ```

3.  **Add PostgreSQL Addon**
    ```bash
    heroku addons:create heroku-postgresql:hobby-dev
    ```

4.  **Deploy Code**
    ```bash
    git push heroku main
    ```

5.  **Run Migrations & Seed**
    ```bash
    heroku run rails db:migrate
    heroku run rails db:seed
    ```

6.  **Open App**
    ```bash
    heroku open
    ```

---

## 🔑 Default Credentials (Seed Data)

| Role | Email | Password |
| :--- | :--- | :--- |
| **Admin** | `admin@smart.com` | `password` |
| **Manager** | `manager@smart.com` | `password` |
| **Sales** | `sales@smart.com` | `password` |
| **Staff** | `staff@smart.com` | `password` |
| **Member** | `aka@gmail.com` | `password` |

---

## 📝 Design Decisions & Improvisations

*   **Public vs Private**: I separated the public view (Catalog only) from the internal CRM to ensure data security.
*   **Dynamic Targets**: Monthly sales targets can be set dynamically by Managers instead of being hardcoded.
*   **UI/UX**: Used Tailwind CSS component classes for a modern, distinct look between "Public" and "Internal" areas.
