# Library Management System

This Library Management System is a relational database project built using MySQL. It is designed to effectively manage all core library operations such as book cataloging, membership tracking, book issuing, fine management, and request handling.

## Database Overview

The system is composed of multiple interrelated tables such as:

- Books and their metadata (title, edition, category, publisher, location, etc.).

- Authors and the many-to-many relationship between books and authors.

- Members with membership status.

- Library Staff and their role in issuing books.

- Book Issue, Fine Due, and Fine Payment tracking.

- Book Requests and availability status.

- Locations for tracking shelf and floor placement.

## Entity-Relationship Diagram

![ER Diagram](ER%20diagram.png)

## Features

- Manage books with title, ISBN, edition, copies, and location.
- Handle many-to-many author-book relationships.
- Member status tracking (active/inactive, student/staff/professional).
- Book issuing and returning with status updates.
- Fine tracking with due and payment details.
- Book availability request management.
- Categorization by genres and physical locations.
- Staff activity tracking.
- Extensive query support for insights & reports.

## How to Use

1. Create the Database:

- SOURCE schema.sql;

- Run Predefined Queries:

- Execute queries from library_sql_queries.sql to get insights such as:

    1) Top 5 authors by number of books

    2) Members with the highest fines

    3) Books not returned yet

    4) Book count by category/floor/shelf

    5) And many more...

## Sample Queries

- Find members who have issued more than 2 books.
  
    SELECT m.first_name, m.last_name, COUNT(*) AS total_issues
  
    FROM member m
  
    JOIN book_issue bi ON m.member_id = bi.member_id
  
    GROUP BY m.member_id
  
    HAVING COUNT(*) > 2;

- Show books currently not available.
  
    SELECT book_title FROM book WHERE copies_available = 0;

- Books with fines due and not returned
    SELECT b.book_title
  
    FROM book b
  
    JOIN book_issue bi ON b.book_id = bi.book_id
  
    LEFT JOIN fine_due f ON bi.issue_id = f.issue_id
  
    WHERE bi.issue_status != 'returned' AND f.fine_id IS NULL;

## Educational Value

This project is ideal for students and developers who want to:

Understand SQL schema design

Practice writing advanced SQL queries (joins, subqueries, aggregate functions, etc.)

Learn how to model real-world entities in databases

Build data-driven dashboards or backend services on top of a SQL database

