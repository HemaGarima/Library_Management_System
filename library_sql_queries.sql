USE library_management;

-- 1 Top 5 authors who have written the highest number of books
SELECT * FROM author;
SELECT * FROM book_author;
SELECT * FROM book;

SELECT a.first_name, a.last_name, COUNT(ba.book_id) AS books_written
FROM author a
JOIN book_author ba ON a.author_id = ba.author_id
GROUP BY a.author_id
ORDER BY books_written DESC
LIMIT 5;

-- 2. List all members who have issued more than 2 books
SELECT * FROM member_status;
SELECT * FROM book_issue;

SELECT m.member_id, m.first_name, m.last_name, COUNT(bi.issue_id) AS total_issues
FROM member m
JOIN book_issue bi ON m.member_id = bi.member_id
GROUP BY m.member_id
HAVING COUNT(bi.issue_id) > 2;

-- 3. List all categories along with total books issued per category
SELECT * FROM category;
SELECT * FROM book;
SELECT * FROM book_issue;

SELECT c.category_name, COUNT(bi.issue_id) AS total_issues
FROM category c
JOIN book b ON c.category_id = b.category_id
JOIN book_issue bi ON b.book_id = bi.book_id
GROUP BY c.category_name;

-- 4. Display the number of books published each year
SELECT * FROM book;

SELECT publication_year, COUNT(*) AS total_books
FROM book
GROUP BY publication_year
ORDER BY publication_year;

-- 5. Find the member(s) who has the highest total fine due
SELECT * FROM fine_due;

SELECT m.member_id, m.first_name, m.last_name, SUM(f.fine_total) AS total_fine
FROM member m
JOIN fine_due f ON m.member_id = f.member_id
GROUP BY m.member_id
ORDER BY total_fine DESC
LIMIT 1;

-- 6. Display books which are currently not available
SELECT * FROM book;
SELECT * FROM book_issue;
SELECT * FROM book_request_status;

SELECT book_id, book_title
FROM book
WHERE copies_available = 0;

-- 7. Find books issued but not yet returned
SELECT * FROM book_issue;
SELECT * FROM book_request_status;
SELECT * FROM book;

SELECT b.book_id, b.book_title, bi.issue_status
FROM book b
JOIN book_issue bi ON b.book_id = bi.book_id
WHERE bi.issue_status NOT IN ('returned');

-- 8. Update the publication year of the book titled 'Mechanics'
SELECT * FROM book;

SET SQL_SAFE_UPDATES = 1;

UPDATE book
SET publication_year = 2021
WHERE book_title = 'Mechanics';

-- 9. Delete all book requests for books that are already available
SELECT * FROM book_request_status;
SELECT * FROM book_request;

DELETE FROM book_request
WHERE available_status_id IN (
  SELECT available_status_id
  FROM book_request_status
  WHERE available_status = 'available'
);

-- 10. Insert a new author and assign them to a new book
SELECT * FROM author;
SELECT * FROM book;
SELECT * FROM book_author;

INSERT INTO author (first_name, last_name) VALUES ('New', 'Author');

INSERT INTO book (isbn_code, book_title, category_id, publisher_id, 
publication_year, book_edition, copies_total, copies_available, location_id)
VALUES ('1234567890123', 'New Book', 1, 1, 2022, 1, 5, 5, 1);

INSERT INTO book_author (book_id, author_id)
VALUES ((SELECT MAX(book_id) FROM book), (SELECT MAX(author_id) FROM author));

-- 11. Display publishers who have published more than 5 different books
SELECT * FROM publisher;
SELECT * FROM book;

SELECT p.publisher_name, COUNT(b.book_id) AS books_published
FROM publisher p
JOIN book b ON p.publisher_id = b.publisher_id
GROUP BY p.publisher_id
HAVING COUNT(b.book_id) > 5;

-- 12. Show the staff members who have issued more than 3 books
SELECT * FROM library_staff;
SELECT * FROM book_issue;

SELECT s.staff_name, COUNT(bi.issue_id) AS total_issues
FROM library_staff s
JOIN book_issue bi ON s.issue_by_id = bi.issue_by_id
GROUP BY s.issue_by_id
HAVING COUNT(bi.issue_id) > 3;

-- 13. Show all cities and the count of members from each
SELECT * FROM member;

SELECT city, COUNT(*) AS member_count
FROM member
GROUP BY city
ORDER BY member_count DESC;

-- 14. List all members who have returned all the books they issued
SELECT * FROM member;
SELECT * FROM book_issue;

SELECT m.member_id, m.first_name, m.last_name
FROM member m
WHERE NOT EXISTS (
  SELECT 1 FROM book_issue bi
  WHERE bi.member_id = m.member_id AND bi.issue_status != 'returned'
);

-- 15. Find books that have been issued but never returned and have no fine recorded
SELECT * FROM book_issue;
SELECT * FROM fine_due;
SELECT * FROM book;

SELECT b.book_id, b.book_title
FROM book b
JOIN book_issue bi ON b.book_id = bi.book_id
LEFT JOIN fine_due f ON bi.issue_id = f.issue_id
WHERE bi.issue_status != 'returned' AND f.fine_id IS NULL;

-- 16. List all books along with their authors, publisher, and category
SELECT * FROM book;
SELECT * FROM author;
SELECT * FROM publisher;
SELECT * FROM category;
SELECT b.book_title, a.first_name, a.last_name, p.publisher_name, c.category_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
JOIN publisher p ON b.publisher_id = p.publisher_id
JOIN category c ON b.category_id = c.category_id;

-- 17. Display all books requested along with requestor's name and request status
SELECT * FROM book_request;
SELECT * FROM book_request_status;

SELECT br.request_id, b.book_title, m.first_name, m.last_name, brs.available_status
FROM book_request br
JOIN book b ON br.book_id = b.book_id
JOIN member m ON br.member_id = m.member_id
JOIN book_request_status brs ON br.available_status_id = brs.available_status_id;

-- 18. Show book title, issue date, return date, member name, and fine (if any)
SELECT * FROM book_issue;
SELECT * FROM fine_due;

SELECT b.book_title, bi.issue_date, bi.return_date, m.first_name, m.last_name, f.fine_total
FROM book_issue bi
JOIN book b ON bi.book_id = b.book_id
JOIN member m ON bi.member_id = m.member_id
LEFT JOIN fine_due f ON bi.issue_id = f.issue_id;

-- 19. List all issues that happened in November 2022
SELECT * FROM book_issue;

SELECT *
FROM book_issue
WHERE issue_date BETWEEN '2022-11-01' AND '2022-11-30';

-- 20. Find books whose publication year is before 1980
SELECT * FROM book;

SELECT book_title, publication_year
FROM book
WHERE publication_year < 1980;

-- 21. List all books along with their shelf number, shelf name, and floor location
SELECT * FROM location;
SELECT * FROM book;

SELECT b.book_title, l.shelf_no, l.shelf_name, l.floor_no
FROM book b
JOIN location l ON b.location_id = l.location_id;

-- 22. Find how many books are kept on each floor
SELECT * FROM location;

SELECT l.floor_no, COUNT(b.book_id) AS total_books
FROM location l
JOIN book b ON b.location_id = l.location_id
GROUP BY l.floor_no
ORDER BY l.floor_no;

-- 23. Find which shelf contains the most number of distinct books
SELECT * FROM location;

SELECT l.shelf_no, l.shelf_name, COUNT(DISTINCT b.book_id) AS books_count
FROM location l
JOIN book b ON l.location_id = b.location_id
GROUP BY l.shelf_no, l.shelf_name
ORDER BY books_count DESC
LIMIT 1;

-- 24. List all books placed on floor number 2
SELECT b.book_title, l.shelf_name
FROM book b
JOIN location l ON b.location_id = l.location_id
WHERE l.floor_no = 2;

-- 25. Show count of books by shelf name
SELECT l.shelf_name, COUNT(b.book_id) AS book_count
FROM location l
JOIN book b ON l.location_id = b.location_id
GROUP BY l.shelf_name
ORDER BY book_count DESC;
