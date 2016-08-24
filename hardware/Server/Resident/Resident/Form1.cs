﻿using System;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Resident
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        private async Task EventLoop()
        {
            while (true)
            {
                try
                {
                    System.IO.Ports.SerialPort serial = new System.IO.Ports.SerialPort("COM2", 9600);
                    serial.DtrEnable = true;
                    serial.Open();
                    Console.WriteLine("COM2と接続しました。");
                    DateTime date = DateTime.Now;
                    while (true)
                    {
                        try
                        {
                            String rcv = serial.ReadLine();
                            if (rcv.Length > 0)
                            {
                                string[] data = rcv.Split(';');
                                if (data.Length > 1)
                                {
                                    WLFModule mod = new WLFModule();

                                    mod.start = date.AddSeconds(uint.Parse(data[0].Split(',')[0]));
                                    mod.end = date.AddSeconds(uint.Parse(data[data.Length - 2].Split(',')[0]));
                                    mod.step = uint.Parse(data[data.Length - 2].Split(',')[1]);


                                    Console.WriteLine(mod.start.ToString() + "～" + mod.end.ToString() + " 歩数:" + mod.step.ToString());

                                    date = DateTime.Now;
                                    mod.execute();
                                }
                            }
                            await Task.Delay(1000);
                        }
                        catch (Exception e)
                        {
                            Console.WriteLine(e.StackTrace);
                            break;
                        }
                    }
                    serial.Close();
                    await Task.Delay(1000);
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.StackTrace);
                    continue;
                }
            }
        }
        private void 終了ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            notifyIcon1.Visible = false;
            Console.WriteLine("終了");
            Application.Exit();
        }
    }
}