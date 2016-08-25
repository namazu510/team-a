using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WLF
{
    public partial class Form1 : Form
    {
        private Task t;
        private Form2 loginform;
        public Form1()
        {
            InitializeComponent();
            t = new Task(() =>
            {
                for (;;)
                {
                    EventLoop();
                    System.Threading.Thread.Sleep(1000);
                }
            });
            t.Start();

        }
        private void EventLoop()
        {
            try
            {
                if (WLFModule.isLogin()) {
                    System.IO.Ports.SerialPort serial = new System.IO.Ports.SerialPort("COM2", 9600);
                    serial.DtrEnable = true;
                    serial.Open();
                    Console.WriteLine("COM2" + "と接続しました。");
                    while (true)
                    {
                        try
                        {
                            String rcv = serial.ReadLine();
                            Console.WriteLine(rcv);
                            if (rcv.Length > 0)
                            {
                                string[] buf;
                                uint time;
                                buf = rcv.Split('=');
                                time = uint.Parse(buf[0]);
                                buf = buf[1].Split('|');
                                if (buf.Length > 0)
                                {
                                    for (int i = 0; i < buf.Length; i++) {
                                        String[] data = buf[i].Split(';');
                                        if (data.Length > 1)
                                        {
                                            WLFModule mod = new WLFModule();

                                            DateTime date = DateTime.Now;
                                            mod.start = date.AddSeconds(long.Parse(data[0].Split(',')[0]) - time);
                                            mod.end = date.AddSeconds(long.Parse(data[data.Length - 2].Split(',')[0]) - time);
                                            mod.step = uint.Parse(data[data.Length - 2].Split(',')[1]);


                                            Console.WriteLine(mod.start.ToString() + "～" + mod.end.ToString() + " 歩数:" + mod.step.ToString());

                                            mod.execute();
                                        }
                                    }
                                }
                            }
                        }
                        catch (Exception e)
                        {
                            //Console.WriteLine(e.StackTrace);
                            break;
                        }
                    }
                    serial.Close();
                }
            }
            catch (Exception e)
            {
                //Console.WriteLine(e.StackTrace);
                return;
            }
        }
        private void Exit_Click(object sender, EventArgs e)
        {
            notifyIcon1.Visible = false;
            Console.WriteLine("終了");
            Application.Exit();
        }
        private void Option_Click(object sender, EventArgs e)
        {
            contextMenuStrip1.Items["toolStripMenuItem1"].Enabled = false;
            loginform = new Form2();
            loginform.ShowDialog(this);
            loginform.Dispose();
            contextMenuStrip1.Items["toolStripMenuItem1"].Enabled = true;

        }
    }
}
