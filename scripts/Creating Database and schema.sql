/* 
----------------------------------------------------
Create Database and Schema for Datawarehouse2
----------------------------------------------------
Script purpose :
- Created a new database named 'Datawarehouse2' after checking if already exists.
1. If database exists, it will be dropped and recreated.
2. Created threee schemas named 'bronze', 'silver' and 'gold' within the 'Datawarehouse' database.

----------------------------------------------------
WARNING:
- Running this script will drop the entire 'Datawarehouse2' database if it already exists.
  So, please use it with caution, especially in a production environment.
- Ensure that you have backed up any important data before executing this script.
----------------------------------------------------
Author: Yan

*/

USE master;

DROP DATABASE IF EXISTS Datawarehouse2;
CREATE DATABASE Datawarehouse2;

USE Datawarehouse2;

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
