-- Useful Scripts 

-- How many patients does doctor Smith have.
-- Table: patient_list 

SELECT SUM (patient_id) FROM patient_list WHERE physician_last_name = 'Smith'; 