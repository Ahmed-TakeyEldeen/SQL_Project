CREATE TABLE job_applied(
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(255)
);

SELECT *
FROM job_applied;


INSERT INTO job_applied (
    job_id,
    application_sent_date,
    custom_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status
)
VALUES(
    1,
    '2024-5-5',
    true,
    'Wazzzaap',
    false,
    'cover-letter1.pdf',
    'submitted'
),
(
    2,
    '2024-3-21',
    false,
    'Wazzzaap',
    true,
    'cover-letter2.pdf',
    'submitted'
);





ALTER TABLE job_applied
ADD contact VARCHAR(255);


UPDATE job_applied
SET contact ='Ahmed TakeyEldeen'
WHERE job_id =1;

UPDATE job_applied
SET contact ='khloud TakeyEldeen'
WHERE job_id =2;

ALTER TABLE job_applied
RENAME COLUMN contact to contact_name;

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

ALTER TABLE job_applied
DROP COLUMN contact_name;

DROP TABLE job_applied;