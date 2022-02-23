CREATE OR REPLACE FUNCTION generate_people()
	RETURNS TABLE (cpr TEXT, firstname TEXT, lastname TEXT, gender TEXT, birthday timestamp, phone TEXT, email TEXT)
	LANGUAGE plpgsql
	VOLATILE
AS
$$
DECLARE
	amount_to_generate int := 500;
	i int := 0;
BEGIN
	FOR i IN 1..amount_to_generate
	LOOP
		-- Here the magic happens:
		SELECT 
			INTO cpr, firstname, lastname, gender, birthday, phone, email -- We SELECT INTO the RETURN TABLE 
				p.cpr, p.firstname, p.lastname, p.gender, p.birthday,p.phone, p.email -- these values
			FROM
				(SELECT tabl.cpr, tabl.firstname, tabl.lastname, tabl.gender, tabl.birthday, tabl.phone, tabl.email 
					FROM generate_person() AS tabl --we name the table from generate_person() tabl
				) 
				AS p; --The resulting TABLE IS CALLED p
		RETURN NEXT; -- RETURN NEXT adds it TO the RETURN TABLE AND continues the loop
	END LOOP;
END; 
$$;

SELECT * FROM generate_people ();