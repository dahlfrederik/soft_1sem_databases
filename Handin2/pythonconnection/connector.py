import psycopg2

# establishing the connection
# Docker is port 5555 | Localhost is 5432
conn = psycopg2.connect(
    database="postgres", user='postgres', password='hemmelighed17', host='127.0.0.1', port='5432'
)
# Creating a cursor object using the cursor() method
cursor = conn.cursor()

# Executing an MYSQL function using the execute() method
cursor.execute("select version()")

# Fetch a single row using fetchone() method.
data = cursor.fetchone()
print("Connection established to: ", data)

cursor.execute("SELECT * FROM employee")
data = cursor.fetchall()
print("All employees from DB: ", data)

# Closing the connection
conn.close()
