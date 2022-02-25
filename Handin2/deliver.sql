--Creating what is needed 
INSERT INTO persons(CPR, first_name,last_name,gender,phone, email) 
VALUES ('010100001', 'John', 'Patient Doe', 'male', 123456789, 'something@something.com');
INSERT INTO persons(CPR, first_name,last_name,gender,phone, email) 
VALUES ('020200001', 'John', 'Doctor Doe', 'male', 123456799, 'somethingdoctor@something.com');
INSERT INTO doctors (CPR,occupation) 
VALUES ('020200001', 'mystery department');
INSERT INTO patients  (CPR,description) 
VALUES ('010100001', 'Special description about whatever');
INSERT INTO cities(postal_code, city) values (2500, 'Herlev');
INSERT INTO address(postal_code, street, house_number) VALUES (2500, 'herlev hovedgade', 1);
INSERT INTO pharmacy(pharmacy_name, address_id) VALUES ('PharmacyHerlev', 2);
-- Displaying it 
SELECT * FROM persons;
SELECT * FROM doctors ;
SELECT * FROM patients ;
SELECT * FROM prescription p ;
SELECT * FROM address a ;
SELECT * FROM pharmacy p ;
-- Calling the function 
SELECT create_prescription('010100001', '020200001', 'Fever', 'Panodil', 4, '2022-02-23 14:01:10-08');
SELECT * FROM prescription;

DROP FUNCTION deliverPrescription(pat_id varchar, med_name varchar, phar_name varchar);

CREATE OR REPLACE FUNCTION deliverPrescription(pat_id varchar, med_name varchar, phar_name varchar)
RETURNS VOID AS
$$
DECLARE 
	pre_id  int;
	phar_id int;
BEGIN
	SELECT prescription_id FROM prescription WHERE patient_id = pat_id AND medicin_name = med_name INTO pre_id;
	SELECT pharmacy_id FROM pharmacy p WHERE p.pharmacy_name = phar_name INTO phar_id;
	UPDATE prescription SET handouts = handouts - 1 WHERE patient_id = pat_id;	
    INSERT INTO delivered(delivered_date, prescription_id, pharmacy_id) VALUES (NOW(), pre_id, phar_id); 
END
$$
LANGUAGE 'plpgsql';
 
SELECT deliverPrescription('010100001', 'Panodil', 'PharmacyHerlev');

SELECT * FROM prescription p  ;


CREATE FUNCTION sendEmail(cpr varchar)
RETURNS VOID
AS $$
import subprocess
subprocess.call(['/usr/bin/python', '/home/python/sendEmail.py ' || cpr])
$$ LANGUAGE plpythonu;

CREATE TRIGGER executePython 
AFTER INSERT ON messages 
FOR EACH ROW EXECUTE PROCEDURE callMyApp();

