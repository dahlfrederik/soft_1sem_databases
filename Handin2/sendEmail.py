import psycopg2
import smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import sys

if __name__ == "__main__":

        # establishing the connection
    # Docker is port 5555 | Localhost is 5432
    conn = psycopg2.connect(
        database="postgres", user='postgres', password='james123.', host='127.0.0.1', port='5432'
    )
    # Creating a cursor object using the cursor() method
    cursor = conn.cursor()

    # Executing an MYSQL function using the execute() method
    cursor.execute("select version()")

    # Fetch a single row using fetchone() method.
    data = cursor.fetchone()
    print("Connection established to: ", data)

    query = """\
    SELECT patient_id, handouts, medicin_name,
    patient_inf.first_name AS patientFirst, patient_inf.last_name AS patientLast, patient_inf.email,
    doctor_inf.first_name AS doctorFirst, doctor_inf.last_name AS doctorLast
    FROM assignment2.prescription p 
    JOIN assignment2.patients p2 ON p.patient_id = p2.cpr
    JOIN assignment2.doctors d ON p.doctor_id = d.cpr
    JOIN assignment2.persons patient_inf ON patient_inf.cpr = p2.cpr 
    JOIN assignment2.persons doctor_inf ON doctor_inf.cpr = d.cpr 
    WHERE p.handouts < 2;"""


    cursor.execute(query)
    data = cursor.fetchall()

    # Closing the connection
    conn.close()

    if data:
        for row in data:
            handouts_count = row[1]
            patient_name = row[3] + " " + row[4]
            patient_email = row[5]
            medicin_name = row[2]
            doctor_name = row[6] + " " + row[7]

            # Send email
            sender_email = "my@gmail.com"
            receiver_email = patient_email
            password = "hemmelig123"

            if handouts_count <=1:
                message = MIMEMultipart("alternative")
                message["Subject"] = "You need more drugs."
                message["From"] = sender_email
                message["To"] = receiver_email

                # Create the plain-text and HTML version of your message
                html = """\
                <html>
                <body>
                    <p>Hi, {}<br>
                    you are running low on {}<br>
                        Please contact doctor {} to get more.<br>
                    </p>
                </body>
                </html>""".format(patient_name, medicin_name, doctor_name)



                # Turn these into plain/html MIMEText objects
                content = MIMEText(html, "html")

                # Add HTML/plain-text parts to MIMEMultipart message
                # The email client will try to render the last part first
                message.attach(content)

                # Create secure connection with server and send email
                context = ssl.create_default_context()
                with smtplib.SMTP("smtp.freesmtpservers.com", 25) as server:
                    server.connect("smtp.freesmtpservers.com", 25)
                    server.sendmail(
                        sender_email, receiver_email, message.as_string()
                    )
                    server.quit()