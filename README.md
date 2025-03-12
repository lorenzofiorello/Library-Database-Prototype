# Library-Database-Prototype
Starter Kit for a Library Database using SQL Server + SSIS

This repository provides a starter kit for managing a library system.  
In the scripts I have used "DB" for the database where you will use it and "schema" for the schema where tables and procedure belong. Remember to change them as you use these scripts for your project.

# Contents

Tables.sql  
This script creates the table "Books", "Users" and "Borrowings".  
The table "Books" will be used to register all the books available in the library, with their respective quantity. For this table I have chosen to not use the field "ISBN" as primary key, to allow the management of books published before 1970, without ISBN.  
The table "Users" will be used to register all the clients of the library, with all infos regarding them such as Name, Surname, ID number, email..  
The table "Borrowings" will be used to register all the borrowings. Each row will tell which client borrowed which book, the day they took the book and the deadline for returning it. Book and client ID columns have a foreign key on the respective ID from "Books" and "users" tables.
