CREATE OR REPLACE FUNCTION generate_name(source_table_name TEXT)
	RETURNS TABLE(fname TEXT, lname TEXT)
	LANGUAGE plpgsql
	VOLATILE 
  AS 
$$
DECLARE
	firstname TEXT;
	lastname TEXT;
BEGIN
	EXECUTE 
		'SELECT ' || source_table_name || '.first_name FROM ' || source_table_name  || ' ORDER BY random() LIMIT 1' INTO firstname;
	EXECUTE 
		'SELECT ' || source_table_name || '.last_name FROM ' || source_table_name  || ' ORDER BY random() LIMIT 1' INTO lastname;
	RETURN QUERY SELECT firstname, lastname;

END;
$$;



CREATE OR REPLACE FUNCTION generate_three_digits()
	RETURNS INT
	LANGUAGE plpgsql 
	VOLATILE 
  AS 
$$ 
DECLARE 
	first_three int;
BEGIN 
	WITH base AS 
	(
		SELECT generate_series (1000, 9990, 10) AS f3
	)
	SELECT f3 FROM base ORDER BY random() LIMIT 1 INTO first_three;
	RETURN first_three;
END;
$$;

CREATE OR REPLACE FUNCTION generate_last_digit(gender TEXT)
	RETURNS INT
	LANGUAGE plpgsql 
	VOLATILE 
  AS 
$$ 
DECLARE
	last_digit int;
BEGIN 
	WITH base AS
	(
		SELECT 
		(CASE WHEN gender = 'Female' THEN
			floor(5 * RANDOM()) * 2--generate_series (0,9,2)
		WHEN gender = 'Male' THEN
			(floor(5 * RANDOM()) * 2) + 1 --generate_series (1,9,2) 
		ELSE
			floor(10 * RANDOM())--generate_series (0,9,1)
		END)
		AS ld
	)
	SELECT ld FROM base ORDER BY random() LIMIT 1 INTO last_digit;
	RETURN last_digit;
END;
$$;

CREATE OR REPLACE FUNCTION generate_last_digits(gender TEXT)
	RETURNS int
	LANGUAGE plpgsql
	VOLATILE 
  AS 
$$
DECLARE 
	first_three int;
	last_digit int;
	res int;
BEGIN 
	SELECT generate_three_digits() INTO first_three;
	SELECT generate_last_digit(gender) INTO last_digit;
	SELECT first_three + last_digit INTO res;
	RETURN res;
END;
$$;

CREATE OR REPLACE FUNCTION generate_birthdate(age int)
	RETURNS date
	LANGUAGE plpgsql
	VOLATILE 
  AS 
$$
DECLARE
	birthyear int;
	res timestamp;
BEGIN
	SELECT 2022-age INTO birthyear;
	WITH base AS 
	(
		SELECT 
			generate_series(
				('' || birthyear || '-01-01')::timestamp without time zone,
				('' || birthyear || '-12-31')::timestamp without time zone,
				'1 day'::INTERVAL
			) as dates
	)
	SELECT date_trunc('day', dates)::date FROM base ORDER BY random() LIMIT 1 INTO res;
	RETURN res;
END;
$$;

CREATE OR REPLACE FUNCTION format_birthdate(birthday DATE)
	RETURNS TEXT 
	LANGUAGE plpgsql 
	VOLATILE 
AS 
$$
DECLARE
	bday TEXT;
	bmon TEXT;
	byear TEXT;
	res TEXT;
BEGIN 
	--1996-08-25 -> 25
	SELECT substring (birthday::TEXT,9,2) INTO bday;
	--1996-08-25 -> 08
	SELECT substring(birthday::TEXT,6,2) INTO bmon;
	-- 1996 -> 96
	SELECT substring(birthday::TEXT, 3,2) INTO byear;
	SELECT bday || bmon || byear INTO res;
	RETURN res;
END;
$$;

CREATE OR REPLACE FUNCTION generate_cpr(birthday DATE, gender TEXT)
	RETURNS TEXT 
	LANGUAGE plpgsql
	VOLATILE 
AS
$$
DECLARE
	res TEXT;
BEGIN 
	SELECT format_birthdate(birthday) || '-' || generate_last_digits(gender) INTO res;
	RETURN res;
END;
$$;

CREATE OR REPLACE FUNCTION generate_random_gender()
	RETURNS TEXT 
	LANGUAGE plpgsql
	VOLATILE 
AS
$$
DECLARE 
	res TEXT;
BEGIN 
	WITH base AS
	(
		SELECT round(random()) AS rand
	) 
	SELECT INTO res 
	(
		CASE WHEN rand = 1 THEN
			'Male'
		ELSE 
			'Female'
		END
	) FROM base;
	RETURN res;
END;
$$;

CREATE OR REPLACE FUNCTION generate_person(source_table_name TEXT)
	RETURNS TABLE (cpr TEXT, firstname TEXT, lastname TEXT, gender TEXT, birthday timestamp, phone TEXT, email TEXT)
	LANGUAGE plpgsql
	VOLATILE
AS
$$
DECLARE
	-- res TABLE (int, TEXT, TEXT, TEXT, timestamp, TEXT, TEXT);
	cpr TEXT;
	firstname TEXT;
	lastname TEXT;
	gender TEXT;
	birthday timestamp;
	phone TEXT;
	email TEXT;
BEGIN
	--generate birthday from random age
	SELECT INTO birthday generate_birthdate ((SELECT age FROM names ORDER BY RANDOM() LIMIT 1));
	-- generate random first and last name
	SELECT INTO firstname, lastname 
		n.fname, n.lname FROM (
			SELECT fname, lname FROM generate_name(source_table_name)
		) AS n; 
	-- generate phone number and email -- consider changing where you get phone number from, as it is not danish
	SELECT INTO phone, email 
		contact.phone, contact.email FROM (
			SELECT names.phone, names.email FROM names ORDER BY random() LIMIT 1
		) AS contact;
	-- generate random gender 
	SELECT INTO gender generate_random_gender();
	SELECT INTO cpr generate_cpr (birthday::DATE, gender);
	RETURN QUERY SELECT cpr, firstname, lastname, gender, birthday, phone, email;
END;
$$;


-- Function to insert prescription 
CREATE OR REPLACE FUNCTION create_prescription(
	patient_id varchar,
	doctor_id varchar,
	description varchar,
	medicin_name varchar,
	handouts int,
	expire_date timestamp)
      RETURNS void AS
      $$
          BEGIN
            INSERT INTO prescription (patient_id, doctor_id, description, medicin_name, handouts, expire_date)
            VALUES(patient_id , doctor_id , description , medicin_name , handouts, expire_date);
          END;
      $$
      LANGUAGE 'plpgsql' VOLATILE;
     
--- Using the function 
--Creating what is needed 
INSERT INTO persons(CPR, first_name,last_name,gender,phone, email) 
VALUES (010100001, 'John', 'Patient Doe', 'male', 123456789, 'something@something.com') 
INSERT INTO persons(CPR, first_name,last_name,gender,phone, email) 
VALUES (020200001, 'John', 'Doctor Doe', 'male', 123456799, 'somethingdoctor@something.com')
INSERT INTO doctors (CPR,occupation) 
VALUES (020200001, 'mystery department')
INSERT INTO patients  (CPR,description) 
VALUES (010100001, 'Special description about whatever')
-- Displaying it 
SELECT * FROM persons 
SELECT * FROM doctors 
SELECT * FROM patients 
-- Calling the function 
SELECT create_prescription('10100001', '20200001', 'Fever', 'Panodil', 4, '2022-02-23 14:01:10-08')
SELECT * FROM prescription 
