CREATE TABLE IF NOT EXISTS Persons (
	CPR varchar(10) PRIMARY KEY,
	first_name varchar(255),
	last_name varchar(255),
	gender varchar(6),
	phone varchar(10),
	email varchar(255)
);

CREATE TABLE IF NOT EXISTS Doctors (
	CPR varchar PRIMARY KEY,
	occupation varchar(255),
	constraint CPR
	foreign key (CPR)
		references Persons(CPR)
);


CREATE TABLE IF NOT EXISTS Patients (
	CPR varchar PRIMARY KEY,
	description varchar(255),
	constraint CPR
	foreign key (CPR)
		references Persons(CPR)
);

CREATE TABLE IF NOT EXISTS Prescription (
	prescription_id SERIAL PRIMARY KEY,
	patient_id varchar,
	doctor_id varchar,
	description varchar(255),
	medicin_name varchar(255),
	handouts int,
	expire_date timestamp,
	constraint patient_id
	foreign key (patient_id)
		references Patients(CPR),
	constraint doctor_id
	foreign key	(doctor_id)
		references Doctors(CPR)
);

CREATE TABLE IF NOT EXISTS Cities (
	postal_code int PRIMARY KEY,
	city varchar(255)
);

CREATE TABLE IF NOT EXISTS Address (
	address_id SERIAL PRIMARY KEY,
	postal_code int,
	street varchar(255),
	house_number varchar(255),
	constraint postal_code 
	foreign key (postal_code)
		references Cities(postal_code)
);

CREATE TABLE IF NOT EXISTS Pharmacy (
	pharmacy_id SERIAL PRIMARY KEY,
	pharmacy_name varchar(255),
	address_id int,
	constraint address_id 
	foreign key (address_id)
		references Address(address_id)
);

CREATE TABLE IF NOT EXISTS Delivered (
	delivered_id SERIAL PRIMARY KEY,
	pharmacy_id int,
	prescription_id int,
	delivered_date timestamp,
	constraint pharmacy_id 
	foreign key (pharmacy_id)
		references Pharmacy(pharmacy_id),
	constraint prescription_id
	foreign key (prescription_id)
		references Prescription(prescription_id)
);

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
