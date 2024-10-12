import psycopg2
import hidden

secrets = hidden.secrets()

conn = psycopg2.connect(host=secrets['host'],
        port=secrets['port'],
        database=secrets['database'], 
        user=secrets['user'], 
        password=secrets['pass'], 
        connect_timeout=3)

cur = conn.cursor()

number = 797404
value = number
for i in range(300) :
    sql = 'INSERT INTO pythonseq (iter, val) VALUES (%s, %s);'
    cur.execute(sql, (i, value))
    value = int((number * 22) / 7) % 1000000
    number=value
    print(sql + " " +str(i))


conn.commit()
cur.close()