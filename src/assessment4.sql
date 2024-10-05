-- Create the email_signup table with the given data:
CREATE TABLE email_signup (
    id INT,
    email_id VARCHAR(255),
    signup_date DATE
);

INSERT INTO email_signup (id, email_id, signup_date)
VALUES
(1, 'Rajesh@Gmail.com', '2022-02-01'),
(2, 'Rakesh_gmail@rediffmail.com', '2023-01-22'),
(3, 'Hitest@Gmail.com', '2020-09-08'),
(4, 'Salil@Gmmail.com', '2019-07-05'),
(5, 'Himanshu@Yahoo.com', '2023-05-09'),
(6, 'Hitesh@Twitter.com', '2015-01-01'),
(7, 'Rakesh@facebook.com', NULL);

-- Query to replace NULL values in signup _date with '1970-01-01':
UPDATE email_signup
SET signup_date = '1970-01-01'
WHERE signup_date IS NULL;

-- Query to find the gmail accounts with the latest and first signup dates and the difference between them:
SELECT 
    COUNT(*) AS count_gmail_account,
    MAX(signup_date) AS latest_signup_date,
    MIN(signup_date) AS first_signup_date,
    DATEDIFF(DAY, MIN(signup_date), MAX(signup_date)) AS diff_in_days
FROM email_signup
WHERE email_id LIKE '%@gmail.com';


