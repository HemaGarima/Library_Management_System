CREATE DATABASE library_management;
USE library_management;

CREATE TABLE category(
category_id INT PRIMARY KEY AUTO_INCREMENT,
category_name VARCHAR(50)
);

CREATE TABLE publisher(
publisher_id INT PRIMARY KEY AUTO_INCREMENT,
publisher_name VARCHAR(50),
publication_language VARCHAR(15),
publication_type VARCHAR(20)
);

CREATE TABLE location(
location_id INT PRIMARY KEY AUTO_INCREMENT,
shelf_no VARCHAR(10),
shelf_name VARCHAR(50),
floor_no INT
);

CREATE TABLE author(
author_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(20),
last_name VARCHAR(20)
);

DROP TABLE book;

CREATE TABLE book(
book_id INT PRIMARY KEY AUTO_INCREMENT,
isbn_code VARCHAR(15),
book_title VARCHAR(50),
category_id INT,
publisher_id INT,
publication_year DATE,
book_edition INT,
copies_total INT,
copies_available INT,
location_id INT,
CONSTRAINT FOREIGN KEY (category_id) REFERENCES category(category_id),
CONSTRAINT FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
CONSTRAINT FOREIGN KEY (location_id) REFERENCES location(location_id)
);

ALTER TABLE book
MODIFY publication_year YEAR;

CREATE TABLE book_author(
book_id INT,
author_id INT,
CONSTRAINT FOREIGN KEY (book_id) REFERENCES book(book_id),
CONSTRAINT FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE member_status(
active_status_id INT PRIMARY KEY AUTO_INCREMENT,
account_type VARCHAR(20),
account_status VARCHAR(10),
membership_start_date DATE,
membership_end_date DATE
);

ALTER TABLE member_status
MODIFY membership_start_date YEAR,
MODIFY membership_end_date YEAR;

CREATE TABLE member(
member_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(20),
last_name VARCHAR(20),
city VARCHAR(20),
mobile_no VARCHAR(10),
email_id VARCHAR(50),
date_of_birth DATE,
active_status_id INT,
CONSTRAINT FOREIGN KEY (active_status_id) REFERENCES member_status(active_status_id)
);

CREATE TABLE library_staff(
issue_by_id INT PRIMARY KEY AUTO_INCREMENT,
staff_name VARCHAR(50),
staff_designation VARCHAR(20)
);

CREATE TABLE book_issue(
issue_id INT PRIMARY KEY AUTO_INCREMENT,
book_id INT,
member_id INT,
issue_date DATE,
return_date DATE,
issue_status VARCHAR(20),
issue_by_id INT,
CONSTRAINT FOREIGN KEY(book_id) REFERENCES book(book_id),
CONSTRAINT FOREIGN KEY(member_id) REFERENCES member(member_id),
CONSTRAINT FOREIGN KEY(issue_by_id) REFERENCES library_staff(issue_by_id)
);

SELECT * FROM book_issue;

CREATE TABLE fine_due(
fine_id INT PRIMARY KEY AUTO_INCREMENT,
member_id INT,
issue_id INT,
fine_date DATE,
fine_total INT,
CONSTRAINT FOREIGN KEY (member_id) REFERENCES member(member_id),
CONSTRAINT FOREIGN KEY (issue_id) REFERENCES book_issue(issue_id)
);

CREATE TABLE fine_payment(
fine_payment_id INT PRIMARY KEY AUTO_INCREMENT,
member_id INT,
payment_date DATE,
payment_amound INT,
CONSTRAINT FOREIGN KEY(member_id) REFERENCES member(member_id)
);

ALTER TABLE fine_payment
RENAME COLUMN payment_amound TO payment_amount;

CREATE TABLE book_request_status(
available_status_id INT PRIMARY KEY AUTO_INCREMENT,
available_status VARCHAR(10),
nearest_available_date date
);

CREATE TABLE book_request(
request_id INT PRIMARY KEY AUTO_INCREMENT,
book_id INT,
member_id INT,
request_date DATE,
available_status_id INT,
CONSTRAINT FOREIGN KEY(book_id) REFERENCES book(book_id),
CONSTRAINT FOREIGN KEY(member_id) REFERENCES member(member_id),
CONSTRAINT FOREIGN KEY(available_status_id) REFERENCES book_request_status(available_status_id)
);

SELECT * FROM author;

INSERT INTO author (first_name , last_name) VALUES ('PK' , 'Nag') , ('JP' , 'Holman'),
('APJ' , 'Kalam') , ('E', 'Sreedharan'),('RL', 'Norton'),
('Amrita', 'Pritam'), ('Mahadevi', 'Verma'), ('Sudha', 'Murthy'), 
('Ruskin', 'Bond'), ('Robert', 'Frost'),
('Rabindranath', 'Tagore'), ('Jack', 'Canfield'), ('Dale', 'Carnegie'), 
('Swami', 'Vivekanand'), ('Munshi', 'Premchand'),('Stephen', 'Covey'), 
('F', 'Beer'), ('R', 'Johnston'), ('Amish', 'Tripathi'), ('Stephen', 'Timoshenko'), 
('Anton', 'Chekhov'), ('Leo', 'Tolstoy'), ('Mahatma', 'Gandhi'), ('JL', 'Nehru'),
('Nelson', 'Mandela') , ('Twinkle' , 'Khanna');

SELECT * FROM category;

INSERT INTO category (category_name) VALUES ('Engineering&Technology'), 
('Spritualism'), ('Self_Development'), ('Literature'), ('History'), 
('Crime'), ('Comedy'), ('Romantic'), ('Folk_Tales'), ('Fiction'), 
('Non_Fiction'), ('Poetry'), ('Drama'), ('Adventure'), ('Mythology');

SELECT * FROM publisher;

INSERT INTO publisher(publisher_name , publication_language,
publication_type) VALUES  ('ABC','English','Journals'), 
('ABC','Hindi','Journals'), ('CBS','English','Handbooks'),
('CBS','Hindi','Handbooks'), ('XYZ','English','Research_Reports'), 
('XYZ','Hindi','Research_Reports'), ('XYZ','English','Books'),
 ('XYZ','Hindi','Books'), ('ZAB','English','Magzines'),
 ('ZAB','Hindi','Magzines');
 
 SELECT * FROM location;
 
 INSERT INTO location(shelf_no , shelf_name , floor_no) VALUES
 ('10001', 'Engineering_Mechanical',1), ('10001', 'Engineering_Mechanical',2), 
 ('10001', 'Engineering_Mechanical',3), ('10002', 'Engineering_Electrical',1), 
 ('10002', 'Engineering_Electrical',2), ('10002', 'Engineering_Electrical',3),
('10003', 'Engineering_Computers',1), ('10003', 'Engineering_Computers',2), 
('10003', 'Engineering_Computers',3), ('20001', 'Philosophy',1), 
('20001', 'Philosophy',2),('20001', 'Philosophy',3), ('20001', 'Philosophy',4),
('20002', 'Spritualism',1), ('20002', 'Spritualism',2), ('20002', 'Spritualism',3), 
('20002', 'Spritualism',4), ('30001', 'Self_Development',1), 
('30001', 'Self_Development',2), ('30001', 'Self_Development',3),
('30002', 'Competitions',1), ('30002', 'Competitions',2), ('30002', 'Competitions',3),
('30003', 'Literature',1), ('30003', 'Literature',2), ('30003', 'Literature',3),
('30003', 'Literature',4), ('40001', 'Journals',1), ('40001', 'Journals',2), 
('40001', 'Journals',3);

SELECT * FROM book;

INSERT INTO book (isbn_code , book_title , category_id , publisher_id , 
publication_year , book_edition , copies_total , copies_available , location_id) VALUES
('9876543210001', 'Thermodynamics', 1, 7, '2016',3,15,10,1),
('9876543210002', 'Heat & Mass Transfer', 1, 7, '2014',2,5,2,2),
('9876543210003', 'Wings of Fire', 11, 7, '1999',1,10,5,18),
('9876543210004', 'Kinematics of Machines', 1, 7, '2012',3,5,5,3),
('9876543210005', 'Khaton ka Safarnama', 8, 8, '1985',1,3,3,24),
('9876543210006', 'Black Rose', 8, 7, '1970',1,1,1,24),
('9876543210007', 'Kagaz Te Kanvas', 8, 8, '1980',1,5,3,25),
('9876543210008', 'Gillu', 4, 8, '1960',1,2,2,26),
('9876543210009', 'How I taught my grandmother to read', 4, 7, '1990',1,5,5,26),
('9876543210010', 'Three Thousand Stitches', 4, 7, '2010',1,5,5,27),
('9876543210011', 'Wise and Otherwise', 4, 7, '2012',1,5,5,26),
('9876543210012', 'The Room on the Roof', 4, 7, '1970',1,5,5,27),
('9876543210013', 'Happy Birthday, World', 11, 7, '2000',1,1,1,27),
('9876543210014', 'The Road Not Taken', 12, 7, '1920',1,1,1,24),
('9876543210015', 'Geetanjali', 12, 7, '1920',3,1,1,25),
('9876543210016', 'The 25 Success Principles', 3, 7, '1980',6,10,5,18),
('9976543210002', 'How to stop worrying and start living', 3, 7, '2005',10,10,2,19),
('9976543210003', 'Karma Yoga', 11, 7, '1980',5,2,2,11),
('9976543210004', 'Godan', 10, 8, '2012',10,2,2,24),
('9976543210005', 'Premashram', 10, 8, '2010',10,2,2,24),
('9976543210006', 'The Seven Habits of Highly Effective People', 3, 7, '2000',15,10,2,20),
('9876543210007', 'Mechanics', 1, 8, '2000',3,3,3,3),
('9876543210008', 'The Immortals of Meluha', 15, 8, '2012',1,3,3,27),
('9876543210009', 'Strengh of Materials', 1, 8, '2000',6,2,2,2),
('9876543210010', 'The Seagull', 13, 8, '1960',1,1,1,27),
('9876543210011', 'War and Peace', 13, 8, '1970',21,1,1,26),
('9876543210012', 'Harijan', 11, 1, '1932',1,1,1,29),
('9876543210013', 'The Story of my experiments with Truth', 11, 8, '1925',1,1,1,26),
('9876543210014', 'The Discovery of India', 5, 8, '1945',1,3,3,24),
('9876543210015', 'Long walk to freedom', 5, 8, '1999',1,2,2,25),
('9876543210016', 'Beyond Religion', 2, 8, '2010',1,2,2,15),
('9876543210017', 'Ikigai', 2, 8, '2010',1,2,0,15),
('9976443210004', 'Gaban', 10, 8, '2012',10,2,0,24),
('9976549210004', 'Idgah', 10, 8, '2012',10,2,0,24);

SELECT * FROM book_author;

INSERT INTO book_author VALUES (1,1),(2,2),(3,3),(4,5),
(5,6),(6,6),(7,6),(8,7),(9,8),(10,8),(11,8),(12,9),(13,9),
(14,10),(15,11),(16,12),(17,13),(18,14),(19,15),(20,15),
(21,16),(22,17),(22,18),(23,19),(24,20),(25,21),(26,22),
(27,23),(28,23),(29,24),(30,25),(31,null);

SELECT * FROM member_status;

INSERT INTO member_status (account_type , account_status , 
membership_start_date , membership_end_date) VALUES 
('student','active','2018','2020'),
('student','active','2019','2021'),
('student','inactive','2016','2017'),
('student','inactive','2015','2016'),
('professional','active','2020','2022'),
('professional','active','2018','2022'),
('professional','inactive','2015','2018'),
('professional','inactive','2016','2016'),
('staff','active','2020','2022'),
('staff','active','2020','2022'),
('staff','inactive','2015','2016');

SELECT * FROM member;

ALTER TABLE member 
MODIFY date_of_birth YEAR;

INSERT INTO member ( first_name , last_name , city , mobile_no ,
email_id , date_of_birth , active_status_id) VALUES
('A','Kumar','Delhi','9999999999','a@xyz.com','1996',1),
('B','Kumar','Delhi','9999999999','b@xyz.com','1990',5),
('C','Kumar','Noida','9999999999','c@xyz.com','2000',3),
('A','Singh','Noida','9999999999','as@xyz.com','2002',2),
('B','Singh','Noida','9999999999','bs@xyz.com','1985',4),
('B','Singh','Noida','9999999999','bs@xyz.com','1985',6),
('C','Singh','Delhi','9999999999','cs@xyz.com','1990',7),
('X','Patel','Delhi','9999999999','x@xyz.com','1990',9),
('Y','Arora','Delhi','9999999999','y@xyz.com','1985',10),
('Z','Khanna','Delhi','9999999999','z@xyz.com','1970',11);

SELECT * FROM library_staff;

INSERT INTO library_staff (staff_name , staff_designation) VALUES
('X Patel', 'Librarian'),
('Y Arora', 'Librarian'),
('R Tiwari', 'Head Librarian');

SELECT * FROM book_issue;

INSERT INTO book_issue (book_id , member_id , issue_date , 
return_date , issue_status , issue_by_id) VALUES 
(7, 1, '2022-01-01', '2022-01-01', 'overdue', 1),
(8, 1, '2022-11-01', '2022-11-15', 'underdue', 1),
(1, 2, '2022-11-10', '2022-11-25', 'underdue', 1),
(10, 2, '2022-11-12', '2022-11-27', 'underdue', 2),
(18, 2, '2022-11-12', '2022-11-27', 'underdue', 2),
(2, 4, '2022-10-10', '2022-10-25', 'overrdue', 1),
(15, 5, '2022-10-10', '2022-10-25', 'overdue', 2);

SELECT * FROM fine_due;

SELECT * FROM member;

INSERT INTO fine_due(member_id , issue_id , fine_date , fine_total)
VALUES (5,2,'2022-11-20',25),
(4,1,'2022-11-20',25),
(1,6,'2022-11-20',150);

SELECT * FROM fine_payment;

INSERT INTO fine_payment(member_id , payment_date , payment_amount)
VALUES (5,'2022-11-20',25),
(4,'2022-11-20',25),
(1,'2022-11-20',150);

SELECT * FROM book_request_status;

INSERT INTO book_request_status(available_status , nearest_available_date)
VALUES('not_avail','2022-11-22'),
('not_avail','2022-11-30'),
('not_avail','2022-11-25'),
('available','2022-11-16');

SELECT * FROM book_request;

INSERT INTO book_request(book_id , member_id , request_date , 
available_status_id) VALUES
(33,1,'2022-11-15',3),
(34,1,'2022-11-15',4),
(33,2,'2022-11-15',4),
(32,4,'2022-11-15',1),
(25,5,'2022-11-15',2);

-- Problem 1 : 
/*
Write a query to display all the member id , member name , 
city , account_type , account_status , membership start 
and end date.
*/
SELECT * FROM member;
SELECT * FROM member_status;
SELECT m.member_id , m.first_name , m.last_name , m.city , 
ms.account_type , ms.account_status , ms.membership_start_date ,
ms.membership_end_date FROM member m JOIN member_status ms ON
m.active_status_id = ms.active_status_id;

-- Problem 2 : 
/*
Write a query to display the member details whose account is inactive.
*/
SELECT m.member_id , m.first_name , m.last_name , m.city , 
ms.account_type , ms.account_status , ms.membership_start_date , 
ms.membership_end_date FROM member m JOIN member_status ms ON
m.active_status_id = ms.active_status_id WHERE
account_status = 'inactive';

-- Problem 3 : 
/*
Write a query to display the member details whose account type is student.
*/
SELECT m.member_id , m.first_name , m.last_name , m.city , 
ms.account_type , ms.account_status, ms.membership_start_date,
ms.membership_end_date FROM member m JOIN member_status ms ON
m.active_status_id = ms.active_status_id WHERE 
account_type = 'student';

-- Problem 4 : 
/*
Write a query to display the member details whose account 
type is student & account is inactive.
*/
SELECT m.member_id , m.first_name , m.last_name , m.city , 
ms.account_type , ms.account_status , ms.membership_start_date,
ms.membership_end_date FROM member m JOIN member_status ms ON
m.active_status_id = ms.active_status_id WHERE 
account_type = 'student' AND account_status = 'inactive';

-- Problem 5 : 
/*
Write a query to display the member deatials who have fine due.
*/
SELECT * FROM fine_due;
SELECT * FROM member;
SELECT m.member_id , m.first_name , m.last_name , m.city,
f.fine_date , f.fine_total , ms.account_type , ms.account_status,
ms.membership_start_date , ms.membership_end_date FROM 
member m JOIN fine_due f ON m.member_id = f.member_id JOIN
member_status ms ON m.active_status_id = ms.active_status_id;

-- Problem 6 : 
/*
Write a query to display the member details who have fine_due 
and account is inactive.
*/
SELECT m.member_id , m.first_name , m.last_name , m.city , 
f.fine_date , f.fine_total , ms.account_type , 
ms.account_status , ms.membership_start_date , 
ms.membership_end_date FROM member m JOIN fine_due f ON 
m.member_id = f.member_id JOIN member_status ms ON 
m.active_status_id = ms.active_status_id WHERE 
account_status = 'inactive';

-- Problem 7 : 
/*
Write a query to display total number of active membership
and inactive membership.
*/
SELECT 'active' AS status , COUNT(*) AS total_members FROM member m 
JOIN member_status ms ON m.active_status_id = ms.active_status_id
WHERE account_status = 'active'
UNION ALL
SELECT 'inactive' AS status , COUNT(*) AS total_members FROM member m JOIN
member_status ms ON m.active_status_id = ms.active_status_id 
WHERE account_status = 'inactive';

-- Problem 8 : 
/*
Write a query to display how many books this library owns.
*/
SELECT * FROM book;
SELECT SUM(copies_total) AS total_books FROM book;

-- Problem 9 : 
/*
Write a query to display how many books are available for 
borrowing.
*/
SELECT SUM(copies_available) AS books_available_for_borrowing
FROM book;

-- Problem 10 : 
/*
Write a query to display category wise book count.
*/
SELECT * FROM category;
SELECT c.category_name , SUM(b.copies_total) AS total_copies
FROM category c JOIN book b ON b.category_id = c.category_id 
GROUP BY c.category_id , c.category_name ORDER BY 
total_copies DESC;

-- Problem 11 : 
/*
Write a query to display total engineering & technology books.
*/
SELECT SUM(copies_total) AS total_engineering_technology_books
FROM category c JOIN book b ON b.category_id = c.category_id
WHERE category_name = 'Engineering&Technology';

-- Problem 12 : 
/*
Write a query to search a book with name 'Three Thousand Stitches'.
*/
SELECT * FROM book;
SELECT * FROM book WHERE book_title = 'Three Thousand Stitches';

-- Problem 13 : 
/*
Write a query to issue book with book_id = 10 to a member with
member_id = 4.
*/
SELECT * FROM book_issue;
INSERT INTO book_issue(book_id , member_id , issue_date , 
return_date , issue_status , issue_by_id) VALUES
(10,4,'2022-11-20','2022-12-05','underdue',1);

UPDATE book SET copies_available = copies_available-1 
WHERE book_id = 10;

SELECT * FROM book_issue WHERE book_id = 10 AND member_id = 4;

-- Problem 14 : 
/*
Write a query to return book with book_id = 10 to a member 
with member_id = 4.
*/
UPDATE book_issue SET issue_status = 'returned' WHERE 
book_id = 10 AND member_id = 4;

SELECT * FROM book;

UPDATE book SET copies_available = copies_available+1 
WHERE book_id = 10;

-- Problem 15 : 
/*
Write a query to show fine details of member with member name 
 = 'A Kumar'.
*/
SELECT m.member_id , m.first_name , m.last_name , m.city , 
f.fine_date , f.fine_total , ms.account_type , ms.account_status,
ms.membership_start_date , ms.membership_end_date FROM 
member m JOIN fine_due f ON m.member_id = f.member_id JOIN
member_status ms ON m.active_status_id = ms.active_status_id 
WHERE m.first_name = 'A' AND m.last_name = 'Kumar';