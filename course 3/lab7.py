import psycopg2
import hidden
import requests
import json

secrets = hidden.secrets()

conn = psycopg2.connect(host=secrets['host'],
        port=secrets['port'],
        database=secrets['database'], 
        user=secrets['user'], 
        password=secrets['pass'], 
        connect_timeout=3)



url = "https://pokeapi.co/api/v2/pokemon/"
cur = conn.cursor()

for i in range(1, 101):
    url_ready = url+str(i)
    response = requests.get(url_ready)
    data = response.json()
    json_data = json.dumps(data)
    sql = 'INSERT INTO pokeapi (id, body) VALUES (%s, %s);'
    cur.execute(sql, (i, json_data))
    print(i)
    if i%20 == 0:
        conn.commit()


conn.commit()
cur.close()