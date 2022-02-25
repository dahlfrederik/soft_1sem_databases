INSERT INTO tempperson (cpr, firstname, lastname, gender, birthday, phone, email)
SELECT p.cpr, p.firstname, p.lastname, p.gender, p.birthday, p.phone, p.email
FROM generate_people(1000) AS p;

PERFORM set_doctor_or_patient();

CREATE OR REPLACE FUNCTION createTestPrescription()
	RETURNS VOID
	LANGUAGE plpgsql
AS $$
DECLARE
	patient_cpr TEXT;
	doctor_cpr TEXT;
BEGIN
	SELECT cpr FROM patients ORDER BY random() LIMIT 1 INTO patient_cpr;
	SELECT cpr FROM doctors ORDER BY random() LIMIT 1 INTO doctor_cpr;
	INSERT INTO prescription (patient_id, doctor_id, description, medicin_name, handouts, expire_date)
		VALUES (patient_cpr, doctor_cpr, 'For headaches', 'Panodil', 1, now());
END;
$$;

SELECT createTestPrescription();