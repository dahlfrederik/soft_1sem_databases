CREATE TABLE IF NOT EXISTS prescription (
  id SERIAL primary key,
  patient_id int NOT null,
  doctor_id int NOT null,
  description varchar(255)NOT null,
  medicin_name varchar(255) NOT null,
  handouts int NOT null,
  expire_date date NOT null
);

CREATE TABLE if not exists delivered (
	delivered_id SERIAL primary key,
	delivered_date date NOT null,
	prescription_id int NOT null,
	CONSTRAINT prescription_id 
	foreign key (prescription_id)
		references prescription(id)
);



INSERT INTO	prescription(patient_id, doctor_id, description, medicin_name, handouts, expire_date)
	VALUES (1, 1, 'for broken pp', 'pp pills', 10, '2022-12-01');
	
SELECT * FROM prescription p;
SELECT * FROM delivered d;
INSERT INTO delivered(delivered_date, prescription_id) VALUES (NOW(), 1); 


CREATE OR REPLACE FUNCTION deliverPrescription(pat_id int, med_name varchar)
RETURNS VOID AS
$$
DECLARE 
	pre_id  int;
BEGIN
	SELECT id FROM prescription WHERE patient_id = pat_id AND medicin_name = med_name INTO pre_id;
	UPDATE prescription SET handouts = handouts - 1 WHERE patient_id = pat_id;	
    INSERT INTO delivered(delivered_date, prescription_id) VALUES (NOW(), pre_id); 
END
$$
LANGUAGE 'plpgsql';
 
 
 
SELECT deliverPrescription(1, 'pp pills');
