# Library-Database-Prototype
Starter Kit for a Library Database using SQL Server + SSIS

This repository provides a starter kit for managing a library system.  
In the scripts I have used "DB" for the database where you will use it and "schema" for the schema where tables and procedure belong. Remember to change them as you use these scripts for your project.

# Contents

Tables.sql  
This script creates the table "Books", "Users" and "Borrowings".  
For the table "Books" I have chosen to not use the field "ISBN" as primary key, to allow the management of books published before 1970, without ISBN.
