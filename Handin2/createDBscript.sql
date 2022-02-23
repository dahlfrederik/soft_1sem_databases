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