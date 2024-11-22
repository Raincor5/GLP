import pymysql
from sshtunnel import SSHTunnelForwarder


SSH_server = SSHTunnelForwarder(
    "host29.codeanyhost.com",
    ssh_port=14221,
    ssh_username="cabox",
    ssh_pkey="codeanywhere.pem",
    remote_bind_address=("127.0.0.1", 3306)
)
SSH_server.start()
print(SSH_server.local_bind_address, SSH_server.local_bind_port)
mydb = pymysql.connect(host="127.0.0.1", user="raincor", password="P7mostas", port=SSH_server.local_bind_port)
print(mydb.get_server_info())
