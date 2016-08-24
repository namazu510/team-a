using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;

namespace SQL
{
    class WLSModule
    {
        public DateTime start { set; get; }
        public DateTime end { set; get; }
        public uint step { set; get; }

        public void execute()
        {
            string url = "http://localhost:58306/";

            System.Net.WebClient wc = new System.Net.WebClient();
            System.Collections.Specialized.NameValueCollection data =
                new System.Collections.Specialized.NameValueCollection();
            data.Add("start_time",start.ToString());
            data.Add("end_time", end.ToString());
            data.Add("step_cnt", step.ToString());
            wc.UploadValues(url, data);
            wc.Dispose();
        }
    }
}
