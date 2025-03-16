# Library-Database-Prototype

This repository provides a starter kit for managing a library system.  
In the scripts I have used "DB" for the database where you will use it and "schema" for the schema where tables and procedures belong. Remember to change them as you use these scripts for your project. For readability purposes, I will not mention again these in the readme.   

# Contents

**Tables.sql**  
This script creates the tables "Books", "Users" and "Borrowings".  
The table "Books" will be used to register all the books available in the library, with their respective quantity. For this table I have chosen to not use the field "ISBN" as primary key, to allow the management of books published before 1970 (which don't have ISBN).  
The table "Users" will be used to register all the clients of the library, with all the necessary infos regarding them such as Name, Surname, ID number, email..  
The table "Borrowings" will be used to register all the borrowings. Each row will tell which client borrowed which book, the day they took the book and the deadline for returning it. Book and client ID columns have a foreign key on the respective ID from "Books" and "users" tables.  

**schema.BorrowingsManager**  
This script creates the stored procedure "BorrowingsManager" which you can use for automatising the registration of borrowings, only in case a registration is possible.  
The stored procedure has three parameters, @ID_Book, @ID_User and @ResultSP.  
@ID_Book must be assigned with the ID of a book in the table "Books".  
@ID_User must be assigned with the ID of a user in the table "Users".  
@ResultSP is the output parameter for printing.  
When this stored procedure is invoked with values assigned to the first two parameters, it will performs some checks on values consistency, and if these succeed, it will create a new row in the "Borrowings" table with the book and the user passed. The field "BorrowingStartDate" takes as value GETDATE(), and for simplicity the field "BorrowingEndDate" will take as value the GETDATE() date, shifted forward by two months. You can edit this shift according to your needs.  

## Next Steps
I will upload a skeleton for a ssis dtsx to import data from excels/txts and a skeleton for its relative configuration file. I will also upload scripts for triggers to automatically save historical data. Please note that personal data archiving is subject to local data protection rules, so be sure to be compliant.

## Contributions
If you'd like to contribute to this project, feel free to **fork** and submit **pull requests**. Please follow the contribution guidelines (if any).  

## Useful Links
- **SQL Server Documentation**: [Microsoft SQL Server Docs](https://docs.microsoft.com/en-us/sql/)  
- **SSIS Documentation**: [SQL Server Integration Services (SSIS)](https://learn.microsoft.com/en-us/sql/integration-services/)  
- **T-SQL Reference**: [Transact-SQL (T-SQL) Reference](https://docs.microsoft.com/en-us/sql/t-sql/language-reference)  
- **SQL Server Downloads**: [Download SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)  
