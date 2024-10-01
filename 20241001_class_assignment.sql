/* SQL installation script: Creating Users and Roles on MySQL
   Name: Prof. Raul nedd      Date Created: 02/03/2024
                            Date Modified: 09/28/2024
  Purpose: This script creates user, create roles and configures their permissions
*/

SELECT '' AS 'Installation Starting!!!';

/* Remove the user if they are already there!!
*/

SELECT '' AS 'Dropping users':

DROP USER IF EXISTS 'guttman_root'@'local_host';
DROP USER IF EXISTS 'test_user_01'@'local_host';
DROP USER IF EXISTS 'test_user_02'@'local_host';
DROP USER IF EXISTS 'test_user_03'@'local_host';
DROP USER IF EXISTS 'test_user_04'@'local_host';
DROP USER IF EXISTS 'test_user_05'@'local_host';


SELECT '' AS 'Creating user';
-- Create a root user
CREATE USER IF NOT EXISTS  'guttman_root'@'localhost'
        IDENTIFIED BY 'grizzlies_2024'
        PASSWORD REQUIRE CURRENT;

--Create test users
CREATE USER IF NOT EXISTS 'test_user_01'@'localhost'
        IDENTIFIED BY 'test_user_20241001'
-- Add some password settings
        FAILED LOGIN ATTEMPTS 4
        PASSWORD_LOCK_TIME 1
        PASSWORD EXPIRE INTERVAL 90 DAY
        PASSWORD HISTORY 5
        PASSWORD REUSE INTERVAL 365 DAY;

CREATE USER IF NOT EXISTS 'test_user_02'@'localhost'
        IDENTIFIED BY 'test_user_20241001'
    Account Resource Limits
        WITH MAX_QUERIES_PER_HOUR 40
             MAX_UPDATES_PER_HOUR 10
             MAX_CONNECTIONS_PER_HOUR 75
             MAX_USER_CONNECTIONS 2
-- More restrictive password settings
        FAILED_LOGIN_ATTEMPTS 1
        PASSWORD_LOCK_TIME UNBOUNDED
        PASSWORD EXPIRE INTERVAL 30 DAY
        PASSWORD HISTORY 25
        PASSWORD REUSE INTERVAL 365 DAY;

CREATE USER IF NOT EXISTS 'test_user_03'@'localhost'
          IDENTIFIED BY 'test_user_20241001';
CREATE USER IF NOT EXISTS 'test_user_04'@'localhost'
          IDENTIFIED BY 'test_user_20241001';
CREATE USER IF NOT EXISTS 'test_user_05'@'localhost'
          IDENTIFIED BY 'test_user_20241001';

-- DROP and Create Roles
SELECT '' AS 'CREATING ROLES';
DROP ROLE IF EXISTS  'read_only_employees_db',
                     'read_department_info';
CREATE ROLE IF NOT EXISTS 'read_only_employees_db',
                          'read_department_info';


SELECT '' AS 'Granting privileges';

-- Give the user root privileges
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD
    ON *.* TO 'guttman_root'@'localhost' WITH GRANT OPTION;

-- Give test user 01 full privileges to testdb_20240919
-- Give test user 01 SELECT privileges to only departments table in
-- employees database

GRANT ALL PRIVILEGES
    ON testdb_20240919.* TO 'test_user_01'@'localhost';

GRANT SELECT
    ON employees.departments TO 'test_user_01'@'localhost';

-- Give test user 02 full privileges to all tables in employees database
GRANT ALL PRIVILEGES
    ON employees.* TO 'test_user_02'@'localhost';

/*Give SELECT to all tables in employees database for role
  read_only_employees_db
*/

GRANT SELECT
    ON employees.*
    TO 'read_only_employees_db';

/*Give SELECT to department table in employees database for role
      read_department_info
*/
GRANT SELECT
    ON employees.departments
    TO 'read_department_info';

GRANT 'read_only_employees_db'
      TO 'test_user_03'@'localhost';
GRANT 'read_department_info'
      TO  'test_user_04'@'localhost',
          'test_user_05'@'localhost';

/*To specify which roles should become active each time a user connects
  to the server and authenticates, use SET DEFAULT ROLE. To set the
  default to all assigned roles for each account created earlier, use
  this statement:
*/
SET DEFAULT ROLE ALL TO
      'test_user_03'@'localhost',
      'test_user_04'@'localhost',
      'test_user_05'@'localhost';

/* Verify that the user with the correct privileges has been
   properly created.
*/

SHOW GRANTS FOR 'guttman_root'@'localhost';
SHOW GRANTS FOR 'test_user_01'@'localhost';
SHOW GRANTS FOR 'test_user_02'@'localhost';
SHOW GRANTS FOR 'test_user_03'@'localhost' USING 'read_only_employees_db';
SHOW GRANTS FOR 'test_user_04'@'localhost' USING 'read_department_info';
SHOW GRANTS FOR 'test_user_05'@'localhost' USING 'read_department_info';

/* See all users created
*/
SELECT user, show_db_priv, account_locked
FROM mysql.user;

/* Force MySQL to update the changes to the user privileges
*/
FLUSH PRIVILEGES;

/* See all users created
*/

SELECT user, show_db_priv, account_locked
FROM mysql.user;
SELECT '' AS 'Installation Completed';
