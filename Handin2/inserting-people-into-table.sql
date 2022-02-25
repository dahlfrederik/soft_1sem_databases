CREATE TABLE tempperson(cpr TEXT PRIMARY KEY, firstname TEXT, lastname TEXT, gender TEXT, birthday timestamp, phone TEXT, email TEXT);

INSERT INTO tempperson (cpr, firstname, lastname, gender, birthday, phone, email)
SELECT p.cpr, p.firstname, p.lastname, p.gender, p.birthday, p.phone, p.email
FROM generate_people(1000) AS p;

PERFORM set_doctor_or_patient();
