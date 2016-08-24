using System;
using System.Collections.Generic;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SQL
{
    class Program
    {
        static void Main(string[] args)
        {
            SerialPort serial = new SerialPort("COM2", 9600);
            serial.DtrEnable = true;
            serial.Open();
            DateTime date = DateTime.Now;
            while (true)
            {
                String rcv=serial.ReadLine();
                if (rcv.Length > 0)
                {
                    string[] data=rcv.Split(';');
                    if (data.Length > 1)
                    {
                        WLSModule mod = new WLSModule();

                        mod.start = date.AddSeconds(uint.Parse(data[0].Split(',')[0]));
                        mod.end = date.AddSeconds(uint.Parse(data[data.Length - 2].Split(',')[0]));
                        mod.step = uint.Parse(data[data.Length - 2].Split(',')[1]);


                        Console.WriteLine(mod.start.ToString()+"～"+mod.end.ToString() + " 歩数:" + mod.step.ToString());

                        date = DateTime.Now;
                        mod.execute();
                    }
                }
            }
            serial.Close();
        }
    }
}
