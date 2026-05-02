# 📚 LibraVault – Library Management System
### Full-Stack: HTML + CSS + JavaScript + PHP + MySQL

---

## 🗂️ PROJECT STRUCTURE

```
library/
│
├── index.html          ← Login / Register page
├── dashboard.html      ← Book catalog & borrowing (users)
├── admin.html          ← Admin panel (manage books & users)
│
├── css/
│   └── style.css       ← All styles (dark theme + gold accents)
│
├── js/
│   ├── auth.js         ← Login / register logic
│   ├── app.js          ← Book catalog & borrow logic
│   └── admin.js        ← Admin panel logic
│
├── api/
│   └── index.php       ← PHP REST API backend
│
└── database.sql        ← MySQL database schema + sample data
```

---

## ⚙️ HOW TO RUN (Step by Step)

### STEP 1 – Install a local server
- Download & install **XAMPP** (https://www.apachefriends.org/)
- Start **Apache** and **MySQL** from the XAMPP Control Panel

### STEP 2 – Set up the database
1. Open **phpMyAdmin**: http://localhost/phpmyadmin
2. Click **New** → create database named `library_db`
3. Click **Import** → upload `database.sql`
4. Click **Go** — all tables and sample data will be created

### STEP 3 – Place the project files
- Copy the entire `library/` folder to:
  - Windows: `C:/xampp/htdocs/library/`
  - Mac:     `/Applications/XAMPP/htdocs/library/`

### STEP 4 – Configure the database connection
- Open `api/index.php`
- Edit these lines with your credentials:
```php
define('DB_HOST', 'localhost');
define('DB_USER', 'root');      // your MySQL username
define('DB_PASS', '');          // your MySQL password
define('DB_NAME', 'library_db');
```

### STEP 5 – Open the website
- Go to: http://localhost/library/index.html

---

## 🔑 DEMO LOGIN CREDENTIALS

| Role  | Email                  | Password  | Plan |
|-------|------------------------|-----------|------|
| Admin | admin@library.com      | admin123  | Paid |
| User  | john@example.com       | user123   | Free |
| User  | jane@example.com       | user123   | Paid |

---

## 🌟 FEATURES

### 👤 User Features
- ✅ Login / Register with plan selection (Free / Paid)
- ✅ Browse the full book catalog
- ✅ Search books by title or author
- ✅ Filter by genre and availability
- ✅ Borrow books (free books for everyone)
- ✅ Borrow premium books (Paid plan only)
- ✅ View "My Borrows" section
- ✅ Return borrowed books
- ✅ Upgrade prompt for locked books

### 🛡️ Admin Features
- ✅ Dashboard with live stats (total books, users, borrowed, overdue, paid users)
- ✅ Manage all books (add, delete)
- ✅ Manage all members (change plan, delete)
- ✅ Toggle books as Free or Paid-only

---

## 🔌 CONNECT FRONTEND TO BACKEND

The JS files currently run in **demo mode** (no backend needed).  
To connect to the real PHP + MySQL backend:

1. Open each JS file (`auth.js`, `app.js`, `admin.js`)
2. Find the sections marked:
   ```
   // --- REAL API CALL (uncomment when backend is ready) ---
   ```
3. **Uncomment** the `fetch()` API call block
4. **Comment out** the demo block below it

---

## 🔒 SECURITY NOTES (for production)

- Hash all passwords with `password_hash()` / `password_verify()` in PHP
- Use JWT or PHP sessions for authentication (not plain base64 tokens)
- Sanitize all SQL inputs (use prepared statements — already done in the PHP file)
- Add HTTPS (SSL certificate) for your domain
- Store DB credentials in environment variables, not in code

---

## 📦 TECH STACK

| Layer     | Technology         |
|-----------|--------------------|
| Frontend  | HTML5, CSS3, Vanilla JS |
| Backend   | PHP 8+             |
| Database  | MySQL 8+           |
| Icons     | Font Awesome 6     |
| Fonts     | Google Fonts (Playfair Display, DM Sans) |
| Server    | Apache (XAMPP)     |

---

© 2025 LibraVault – Library Management System
