-- ============================================
-- LIBRARY MANAGEMENT SYSTEM - DATABASE SCHEMA
-- ============================================

CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- USERS TABLE
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,  -- store hashed passwords (bcrypt)
    role ENUM('user', 'admin') DEFAULT 'user',
    plan ENUM('free', 'paid') DEFAULT 'free',
    avatar VARCHAR(255) DEFAULT NULL,
    joined_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- BOOKS TABLE
CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(150) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    genre VARCHAR(80),
    description TEXT,
    cover_image VARCHAR(255) DEFAULT NULL,
    total_copies INT DEFAULT 1,
    available_copies INT DEFAULT 1,
    published_year INT,
    publisher VARCHAR(150),
    language VARCHAR(50) DEFAULT 'English',
    pages INT,
    is_paid_only BOOLEAN DEFAULT FALSE,  -- TRUE = only paid users can borrow
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- BORROW RECORDS TABLE
CREATE TABLE borrow_records (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    due_date DATE NOT NULL,
    return_date TIMESTAMP NULL DEFAULT NULL,
    status ENUM('borrowed', 'returned', 'overdue') DEFAULT 'borrowed',
    fine_amount DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

-- RESERVATIONS TABLE
CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    reserved_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'fulfilled', 'cancelled') DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(id) ON DELETE CASCADE
);

-- CATEGORIES TABLE
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- BOOK_CATEGORIES (Many-to-Many)
CREATE TABLE book_categories (
    book_id INT,
    category_id INT,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- NOTIFICATIONS TABLE
CREATE TABLE notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ============================================
-- SAMPLE DATA
-- ============================================

-- Default admin user (password: admin123 - hash this in production!)
INSERT INTO users (name, email, password, role, plan) VALUES
('Admin User', 'admin@library.com', '$2b$12$xOPXRcoglxxjaPWLGaUcH.uv9boM/6zYXGm7fG6QVjP72xughL.Mi', 'admin', 'paid'),
('John Doe', 'john@example.com', '$2b$12$QZ1IteF4IF5UjZQdOt.3TeApBw/zbOfW7d778tiA49y6aOpBeBKV6', 'user', 'free'),
('Jane Smith', 'jane@example.com', '$2b$12$r.3k9U7wHdbLe/cIxxAIeOa8woxs46/oC9iICvcdjIFbpQMeBWXpO', 'user', 'paid');

-- Sample books
INSERT INTO books (title, author, isbn, genre, description, total_copies, available_copies, published_year, pages, is_paid_only) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 'Fiction', 'A story of the fabulously wealthy Jay Gatsby.', 3, 3, 1925, 180, FALSE),
('To Kill a Mockingbird', 'Harper Lee', '9780061935466', 'Fiction', 'A story of racial injustice and moral growth.', 2, 2, 1960, 281, FALSE),
('1984', 'George Orwell', '9780451524935', 'Dystopian', 'A chilling prophecy about the future.', 4, 4, 1949, 328, FALSE),
('Clean Code', 'Robert C. Martin', '9780132350884', 'Technology', 'A handbook of agile software craftsmanship.', 2, 2, 2008, 431, TRUE),
('The Pragmatic Programmer', 'Andrew Hunt', '9780201616224', 'Technology', 'Your journey to mastery.', 2, 2, 1999, 352, TRUE),
('Dune', 'Frank Herbert', '9780441013593', 'Sci-Fi', 'A science fiction masterwork.', 3, 3, 1965, 412, FALSE),
('The Alchemist', 'Paulo Coelho', '9780062315007', 'Fiction', 'A journey of self-discovery.', 3, 3, 1988, 208, FALSE),
('Sapiens', 'Yuval Noah Harari', '9780062316097', 'Non-Fiction', 'A brief history of humankind.', 2, 2, 2011, 443, TRUE),
('Design Patterns', 'Gang of Four', '9780201633610', 'Technology', 'Elements of reusable object-oriented software.', 1, 1, 1994, 395, TRUE),
('The Hobbit', 'J.R.R. Tolkien', '9780547928227', 'Fantasy', 'A fantasy adventure classic.', 4, 4, 1937, 310, FALSE);

-- Sample categories
INSERT INTO categories (name) VALUES ('Fiction'), ('Technology'), ('Science'), ('History'), ('Fantasy'), ('Dystopian'), ('Non-Fiction');
