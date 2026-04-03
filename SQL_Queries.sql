-- ============================================================
-- QA Portfolio - SQL Queries
-- Project: User Registration & Login System
-- Table: users (id, name, email, password, created_at)
-- Purpose: Database validation queries used for QA testing
-- ============================================================



-- ===========================================================================
-- TC_DB_REG_001 :: Register: User data is saved correctly after registration
-- ===========================================================================
SELECT * 
FROM users 
WHERE email = 'ali@test.com';
-- Expected: 1 record returns with correct name, emaill, and created_at.
-- Email should be stored in correct and consistent format without modification.



-- ===========================================================================
-- TC_DB_REG_002 :: Register: Password is stored as hash and not plain text
-- ===========================================================================
SELECT password 
FROM users 
WHERE email = 'ali@test.com';
-- Expected: Password is stored as hash value and not in plain text '123456'



-- ===========================================================================
-- TC_DB_REG_003 :: Register: Duplicate email is not saved
-- ===========================================================================
SELECT COUNT(*) 
FROM users 
WHERE email='ali@test.com';
-- Expected: Count = 1



-- ===========================================================================
-- TC_DB_REG_004 :: Register: created_at is auto populated
-- ===========================================================================
SELECT created_at 
FROM users 
WHERE email='ali@test.com';
-- Expected: created_at field is not NULL and has correct timestamp



-- ===========================================================================
-- TC_DB_REG_005 :: Register: id is auto incremented
-- ===========================================================================
SELECT email, id 
FROM users 
WHERE email IN ('ali@test.com', 'aliya@test.com');
-- Expected: User 2 id = User 1 id +1



-- ===========================================================================
-- TC_DB_REG_006 :: Register: Verify no NULL values in required fields
-- ===========================================================================
SELECT * 
FROM users 
WHERE email IS NULL 
   OR name IS NULL 
   OR password IS NULL 
   OR created_at IS NULL 
   OR id IS NULL;
-- Expected: No rows (0 rows) return



-- ===========================================================================
-- TC_DB_REG_007 :: Register: Verify Email uniqueness constraint in DB
-- (Attempt to manually insert duplicate - should fail)
-- ===========================================================================
INSERT INTO users (name, email, password, created_at) 
VALUES ('Ali Khan Two', 'ali@test.com', 'abcdef', NOW());
-- Expected: DB throws unique constraint error

SELECT COUNT(*) 
FROM users 
WHERE email='ali@test.com';
-- Expected: Count=1



-- ===========================================================================
-- TC_DB_REG_008 :: Register: Verify database enforces field length constraints
-- ===========================================================================
INSERT INTO users (name, email, password, created_at) 
VALUES ('<very_long_name>', '<very_long_email>', '<very_long_password>', NOW());
-- Expected: Insertion operation fails OR data is truncated
-- DB throws field length constraint error



-- ===========================================================================
-- TC_DB_REG_009 :: Register: Verify no partial or invalid data is stored after failed registration
-- ===========================================================================
SELECT * 
FROM users 
WHERE name = 'Ali Khan';
-- Expected: No record is inserted
-- No partial data exists



-- ===========================================================================
-- TC_E2E_001 :: Verify successful registration -> login flow
-- ===========================================================================
SELECT *
FROM users
WHERE email = 'ali@test.com';
-- Expected: 1 row with all fields populated correctly



-- ===========================================================================
-- TC_E2E_002 :: Verify system prevents duplicate user registration
-- ===========================================================================
SELECT *
FROM users
WHERE email = 'ali@test.com';
-- Expected: 1 row with all fields populated correctly



-- ===========================================================================
-- TC_E2E_004 :: Verify invalid registration does not create user
-- ===========================================================================
SELECT *
FROM users
WHERE name = 'Ali Khan Two';
-- Expected: no record returns



-- ===========================================================================
-- TC_E2E_005 :: Verify multiple users can register independently
-- ===========================================================================
SELECT *
FROM users
WHERE email = 'ali@test.com'
   OR email = 'aliya@test.com';
-- Expected: 2 records return, one for each user



-- ===========================================================================
-- Update user
-- ===========================================================================
UPDATE users 
SET name = 'Ali Updated' 
WHERE email = 'ali@test.com';



-- ===========================================================================
-- Join
-- ===========================================================================
SELECT users.name, orders.product
FROM users
INNER JOIN orders ON users.id = orders.user_id
WHERE users.email = 'ali@test.com';


-- ===========================================================================
-- ORDER BY + LIMIT
-- ===========================================================================
SELECT * FROM users 
ORDER BY created_at DESC 
LIMIT 5;



-- ===========================================================================
-- Like
-- ===========================================================================
SELECT * FROM users 
WHERE email LIKE '%@test.com';



-- ===========================================================================
-- View all users (for debugging)
-- ===========================================================================
SELECT *
FROM users
ORDER BY created_at DESC;



-- ===========================================================================
-- CLEANUP: Delete test users after testing 
-- ===========================================================================
DELETE FROM users
WHERE email IN ('ali@test.com', 'aliya@test.com');
-- Expected: deletes records