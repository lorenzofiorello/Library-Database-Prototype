USE DB
GO

IF OBJECT_ID('schema.Books') IS NULL
BEGIN
CREATE TABLE schema.Books (
  ID INT IDENTITY(1,1) NOT NULL,
  Title VARCHAR(1000) NOT NULL,
  Author VARCHAR(1000) NULL,
  ISBN VARCHAR(13) UNIQUE NULL,
  Quantity INT NOT NULL
)

	ALTER TABLE schema.Books ADD CONSTRAINT PK_Books PRIMARY KEY (ID)

END

IF OBJECT_ID('schema.Users') IS NULL
BEGIN
CREATE TABLE schema.Users (
  ID INT IDENTITY(1,1) NOT NULL,
  [Name] VARCHAR(100) NOT NULL,
  Surname VARCHAR(100) NOT NULL,
  ID_Code VARCHAR(13) UNIQUE NOT NULL,
  Telephone VARCHAR(50) NULL,
  Email VARCHAR(1000) NULL
)

	ALTER TABLE schema.Users ADD CONSTRAINT PK_Users PRIMARY KEY (ID)

END

IF OBJECT_ID('schema.Borrowings') IS NULL
BEGIN
CREATE TABLE schema.Borrowings (
  ID INT IDENTITY(1,1) NOT NULL,
  ID_Book INT NOT NULL,
  ID_User INT NOT NULL,
  BorrowingStartDate DATE NOT NULL,
  BorrowingEndDate DATE NOT NULL,
  Active BIT NOT NULL
)

	ALTER TABLE schema.Borrowings ADD CONSTRAINT PK_Borrowings PRIMARY KEY (ID)

	ALTER TABLE schema.Borrowings ADD CONSTRAINT FK_Borrowings_Book FOREIGN KEY
	(
	ID_Book
	)REFERENCES schema.Books
	(
	ID
	)
	ON DELETE CASCADE
	ON UPDATE CASCADE

	ALTER TABLE schema.Borrowings ADD CONSTRAINT FK_Borrowings_Users FOREIGN KEY
	(
	ID_User
	)REFERENCES schema.Users
	(
	ID
	)
	ON DELETE CASCADE
	ON UPDATE CASCADE

END

-- insert example
INSERT INTO schema.Books(Title,Author,ISBN, Quantity)
VALUES ('The Art of War', 'Sun Tzu', 'ABCDEFGHIJ', 1),
 ('The Great Gatsby', 'J. Scott Fitzgerald', 'HGDBNSMKUTRY', 1)

 INSERT INTO schema.Users([Name],Surname, ID_Code, Telephone, Email)
VALUES ('Lou', 'Read', 'GD85494325', '3375894575', 'lou.reads@gmail.com')
