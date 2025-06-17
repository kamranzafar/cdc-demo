-- SQL Server
CREATE DATABASE TESTDB;
USE TESTDB;

CREATE TABLE messages(id INT, msg VARCHAR(255))

EXEC sys.sp_cdc_enable_db;

EXEC sys.sp_cdc_enable_table
    @source_schema = N'dbo',         -- Schema of the table
    @source_name   = N'messages',   -- Table name
    @role_name     = NULL;
